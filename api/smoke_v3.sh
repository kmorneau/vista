#!/usr/bin/env bash
set -euo pipefail

ROOT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
BACKEND_PORT="${BACKEND_PORT:-19131}"
BACKEND_BASE="http://localhost:${BACKEND_PORT}"
ARTURO_BIN="${ARTURO_BIN:-arturo}"

BACKEND_LOG="${BACKEND_LOG:-/tmp/vista_api_v3_backend.log}"

cleanup() {
  [[ -n "${BACKEND_PID:-}" ]] && kill "${BACKEND_PID}" >/dev/null 2>&1 || true
}
trap cleanup EXIT

echo "Starting Arturo backend on ${BACKEND_BASE}"
(cd "${ROOT_DIR}" && API_PORT="${BACKEND_PORT}" "${ARTURO_BIN}" api/server.art >"${BACKEND_LOG}" 2>&1) &
BACKEND_PID=$!
sleep 0.8

STAMP="$(date +%s)"
CLIENT_ID="v3-client-${STAMP}"
EMAIL="v3${STAMP}@example.com"
PASS="Password123abc"

echo "GET /api/v2/security/csrf/${CLIENT_ID}"
CSRF_RAW="$(curl -sS "${BACKEND_BASE}/api/v2/security/csrf/${CLIENT_ID}")"
CSRF="$(python3 -c 'import json,sys; print(json.loads(sys.stdin.read()).get("data",{}).get("token",""))' <<<"${CSRF_RAW}" | tr -d '\r\n')"
if [[ -z "${CSRF}" ]]; then
  echo "FAIL: csrf token missing"
  echo "${CSRF_RAW}"
  exit 1
fi

echo "POST /api/v2/auth/signup"
SIGNUP_RES="$(curl -sS -X POST "${BACKEND_BASE}/api/v2/auth/signup" \
  -H "Content-Type: application/json" \
  -H "x-client-id: ${CLIENT_ID}" \
  -H "x-csrf-token: ${CSRF}" \
  -d "{\"email\":\"${EMAIL}\",\"password\":\"${PASS}\"}")"
echo "${SIGNUP_RES}" | grep -Eq '"ok"[[:space:]]*:[[:space:]]*true' || { echo "FAIL: signup failed"; echo "${SIGNUP_RES}"; exit 1; }

echo "POST /api/v2/auth/login"
LOGIN_RES="$(curl -sS -X POST "${BACKEND_BASE}/api/v2/auth/login" \
  -H "Content-Type: application/json" \
  -H "x-client-id: ${CLIENT_ID}" \
  -H "x-csrf-token: ${CSRF}" \
  -d "{\"email\":\"${EMAIL}\",\"password\":\"${PASS}\"}")"
echo "${LOGIN_RES}" | grep -Eq '"ok"[[:space:]]*:[[:space:]]*true' || { echo "FAIL: login failed"; echo "${LOGIN_RES}"; exit 1; }

echo "PASS: native v2 JSON/header smoke completed"
