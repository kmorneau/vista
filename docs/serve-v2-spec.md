# `serve.v2` Specification (Draft)

## Goal

Provide first-class HTTP request body and header access in Arturo server handlers while preserving backward compatibility with existing `serve` route definitions.

## Current status in this repo

- Core Arturo runtime `serve` does not currently expose request body/headers in route handlers.
- Practical adapter is implemented at:
  - `api/serve_v2.art` (Arturo entrypoint)
  - `api/server_v3_bridge.js` (HTTP adapter runtime)
- Contract smoke:
  - `tests/serve-v2-smoke.sh`
  - `tests/serve-v2-contract.sh`

## Design principles

- Backward compatible: existing `serve` behavior and route blocks stay unchanged.
- Opt-in: `serve.v2` is a new entrypoint.
- Explicit request/response objects in handlers.
- Safe defaults: body size limit, JSON parsing guards, header normalization.

## Proposed API

### Server startup

```arturo
serve.v2 .port:18969 .max_body_bytes:1048576 [
    POST "/api/v3/auth/login" $[req res][
        payload: req\body_json
        csrf: req\headers\x-csrf-token
        if any? @[equal? payload null equal? csrf ""] [
            return res\json 400 #[
                ok: false
                error: #[code:"bad_request" message:"missing payload or csrf"]
            ]
        ]
        res\json 200 #[ok:true data:#[email: payload\email]]
    ]
]
```

### Handler signature

- v1 style (existing): `POST "/x" [ ... ]`
- v2 style (new): `POST "/x" $[req res][ ... ]`

## Request object contract (`req`)

- `req\method` string (uppercase), e.g. `POST`
- `req\path` string, URL path only
- `req\query` dictionary of query params
- `req\params` dictionary of route params
- `req\headers` dictionary of lowercase header keys
- `req\body_raw` string request body
- `req\body_json` dictionary/null (parsed JSON object only)
- `req\ip` string remote address (best effort)

Notes:
- Header keys MUST be lowercase.
- If body is empty, `req\body_raw` is `""` and `req\body_json` is `null`.
- If `content-type` includes `application/json` but parse fails, router should return `400` before handler.

## Response object contract (`res`)

- `res\status code` -> sets response status code
- `res\set_header key value` -> sets response header
- `res\json code payload` -> writes JSON response and ends request
- `res\text code body` -> writes text response and ends request

Behavior:
- `res\json` sets `content-type: application/json; charset=utf-8`.
- `res\text` sets `content-type: text/plain; charset=utf-8` unless already set.
- If handler returns plain Arturo value and never calls `res\*`, fallback is current `serve` behavior.

## Safety defaults

- `max_body_bytes` default: `1048576` (1MB)
- Request exceeding limit -> `413` with JSON error:
  - `code: "payload_too_large"`
- JSON parse failure -> `400` with JSON error:
  - `code: "invalid_json"`
- Unsupported transfer/content encoding -> `415` (optional first version may reject generically as `400`)

## Compatibility model

- `serve` remains unchanged.
- `serve.v2` shares same route DSL and regex matching behavior.
- Existing route regex captures continue to work and populate `req\params`.

## Minimum acceptance criteria

1. Handler can read headers and body JSON.
2. Route params and query params are available in `req`.
3. Oversized request is rejected with `413`.
4. Invalid JSON request is rejected with `400`.
5. Existing `serve` scripts run unchanged.

## Migration recommendation

1. Keep existing v1/v2 path-param routes.
2. Add parallel v3 JSON/header routes on `serve.v2`.
3. Update clients.
4. Remove encoded-payload workaround after parity is proven.
