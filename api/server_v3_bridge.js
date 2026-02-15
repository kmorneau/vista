#!/usr/bin/env node
"use strict";

const http = require("http");
const { URL } = require("url");

const PORT = Number(process.env.API_V3_PORT || process.env.API_PORT || 18979);
const BACKEND_BASE = (process.env.API_BACKEND_BASE || "http://localhost:18969").replace(/\/+$/, "");
const MAX_BODY_BYTES = Number(process.env.API_V3_MAX_BODY_BYTES || 1048576);
const SENSITIVE_HEADERS = new Set(["authorization", "cookie", "set-cookie", "x-auth-token", "x-api-key"]);

const json = (res, status, payload) => {
  const body = JSON.stringify(payload);
  res.writeHead(status, {
    "content-type": "application/json",
    "content-length": Buffer.byteLength(body),
  });
  res.end(body);
};

const b64url = (value) => Buffer.from(value, "utf8").toString("base64").replace(/\+/g, "-").replace(/\//g, "_").replace(/=+$/g, "");

const readJsonBody = (req) =>
  new Promise((resolve, reject) => {
    let data = "";
    let bytes = 0;
    let done = false;
    req.on("data", (chunk) => {
      bytes += chunk.length;
      if (bytes > MAX_BODY_BYTES) {
        const err = new Error("request body too large");
        err.code = "payload_too_large";
        err.status = 413;
        done = true;
        req.destroy();
        reject(err);
        return;
      }
      if (done) {
        return;
      }
      data += chunk.toString("utf8");
    });
    req.on("end", () => {
      if (done) {
        return;
      }
      if (!data.trim()) {
        resolve({});
        return;
      }
      try {
        resolve(JSON.parse(data));
      } catch (_err) {
        const err = new Error("body must be valid JSON");
        err.code = "invalid_json";
        err.status = 400;
        reject(err);
      }
    });
    req.on("error", reject);
  });

const redactHeader = (name, value) => (SENSITIVE_HEADERS.has(name) ? "[REDACTED]" : value);

const callBackend = async (method, path) => {
  const response = await fetch(`${BACKEND_BASE}${path}`, { method });
  const text = await response.text();
  let payload = null;
  try {
    payload = JSON.parse(text);
  } catch (_err) {
    payload = {
      ok: false,
      error: {
        code: "backend_parse_error",
        message: "Backend returned non-JSON payload",
        details: { body: text.slice(0, 200) },
      },
    };
  }
  return { status: response.status || 200, payload };
};

const required = (obj, fields) => {
  for (const field of fields) {
    if (obj[field] === undefined || obj[field] === null || String(obj[field]).trim() === "") {
      return field;
    }
  }
  return "";
};

const notFound = (res) =>
  json(res, 404, {
    ok: false,
    error: { code: "not_found", message: "Route not found", details: {} },
  });

const badRequest = (res, message, details = {}) =>
  json(res, 400, {
    ok: false,
    error: { code: "bad_request", message, details },
  });

const server = http.createServer(async (req, res) => {
  try {
    const method = req.method || "GET";
    const u = new URL(req.url || "/", "http://localhost");
    const path = u.pathname;

    if (method === "GET" && path === "/api/v3/health") {
      json(res, 200, {
        ok: true,
        data: { status: "up", service: "vista-api-v3-bridge", backend_base: BACKEND_BASE },
      });
      return;
    }

    if (method === "GET" && path === "/__servev2/health") {
      json(res, 200, {
        ok: true,
        data: { status: "up", method, max_body_bytes: MAX_BODY_BYTES },
      });
      return;
    }

    const echoMatch = path.match(/^\/__servev2\/echo\/([^/]+)$/);
    if (method === "POST" && echoMatch) {
      const id = decodeURIComponent(echoMatch[1]);
      let body = {};
      let bodyRaw = "";
      try {
        body = await readJsonBody(req);
        bodyRaw = JSON.stringify(body);
      } catch (err) {
        const status = Number(err && err.status) || 400;
        const code = (err && err.code) || "bad_request";
        json(res, status, {
          ok: false,
          error: { code, message: String(err && err.message ? err.message : err), details: {} },
        });
        return;
      }
      const headers = {};
      for (const [k, v] of Object.entries(req.headers || {})) {
        const key = String(k).toLowerCase();
        const val = Array.isArray(v) ? v.join(",") : String(v || "");
        headers[key] = redactHeader(key, val);
      }
      const query = {};
      for (const [k, v] of u.searchParams.entries()) {
        query[k] = v;
      }
      json(res, 200, {
        ok: true,
        data: {
          method,
          path,
          params: { id },
          query,
          headers,
          body_raw: bodyRaw,
          body_json: body,
        },
      });
      return;
    }

    const csrfMatch = path.match(/^\/api\/v3\/security\/csrf\/([^/]+)$/);
    if (method === "GET" && csrfMatch) {
      const clientId = decodeURIComponent(csrfMatch[1]);
      const r = await callBackend("GET", `/api/v2/security/csrf/${encodeURIComponent(clientId)}`);
      json(res, r.status, r.payload);
      return;
    }

    const routeMap = {
      "POST /api/v3/auth/signup": { v2: "/api/v2/auth/signup", fields: ["email", "password"] },
      "POST /api/v3/auth/login": { v2: "/api/v2/auth/login", fields: ["email", "password"] },
      "POST /api/v3/auth/mfa/verify": { v2: "/api/v2/auth/mfa/verify", fields: ["challenge_id", "code"] },
      "PUT /api/v3/auth/email": { v2: "/api/v2/auth/email", fields: ["token", "email"] },
      "PUT /api/v3/auth/password": { v2: "/api/v2/auth/password", fields: ["token", "old_password", "new_password"] },
      "POST /api/v3/auth/logout": { v2: "/api/v2/auth/logout", fields: ["token"] },
    };

    const key = `${method} ${path}`;
    if (!routeMap[key]) {
      notFound(res);
      return;
    }

    const clientId = String(req.headers["x-client-id"] || "").trim();
    const csrf = String(req.headers["x-csrf-token"] || "").trim();
    if (!clientId) {
      badRequest(res, "x-client-id header is required", { header: "x-client-id" });
      return;
    }
    if (!csrf) {
      badRequest(res, "x-csrf-token header is required", { header: "x-csrf-token" });
      return;
    }

    const body = await readJsonBody(req);
    if (typeof body !== "object" || Array.isArray(body)) {
      badRequest(res, "body must be a JSON object");
      return;
    }
    const missing = required(body, routeMap[key].fields);
    if (missing) {
      badRequest(res, "validation failed", { field: missing, message: `${missing} is required` });
      return;
    }

    const payload = b64url(JSON.stringify(body));
    const backendPath = `${routeMap[key].v2}/${encodeURIComponent(clientId)}/${encodeURIComponent(csrf)}/${encodeURIComponent(payload)}`;
    const r = await callBackend(method, backendPath);
    json(res, r.status, r.payload);
  } catch (err) {
    const status = Number(err && err.status) || 500;
    const code = (err && err.code) || "server_error";
    json(res, status, {
      ok: false,
      error: {
        code,
        message: "Bridge request failed",
        details: { error: String(err && err.message ? err.message : err) },
      },
    });
  }
});

server.listen(PORT, () => {
  process.stdout.write(`:: v3 bridge listening on ${PORT} -> ${BACKEND_BASE}\n`);
});
