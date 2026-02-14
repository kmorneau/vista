#!/usr/bin/env bash
set -euo pipefail

ROOT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
BACKEND_PORT="${BACKEND_PORT:-19131}"
BRIDGE_PORT="${API_V3_PORT:-19132}"
BACKEND_BASE="http://localhost:${BACKEND_PORT}"
BRIDGE_BASE="http://localhost:${BRIDGE_PORT}"

BACKEND_LOG="${BACKEND_LOG:-/tmp/vista_api_v3_backend.log}"
BRIDGE_LOG="${BRIDGE_LOG:-/tmp/vista_api_v3_bridge.log}"

cleanup() {
  [[ -n "${BRIDGE_PID:-}" ]] && kill "${BRIDGE_PID}" >/dev/null 2>&1 || true
  [[ -n "${BACKEND_PID:-}" ]] && kill "${BACKEND_PID}" >/dev/null 2>&1 || true
}
trap cleanup EXIT

echo "Starting Arturo backend on ${BACKEND_BASE}"
(cd "${ROOT_DIR}" && API_PORT="${BACKEND_PORT}" arturo api/server.art >"${BACKEND_LOG}" 2>&1) &
BACKEND_PID=$!
sleep 0.8

echo "Starting v3 bridge on ${BRIDGE_BASE}"
(cd "${ROOT_DIR}" && API_V3_PORT="${BRIDGE_PORT}" API_BACKEND_BASE="${BACKEND_BASE}" node api/server_v3_bridge.js >"${BRIDGE_LOG}" 2>&1) &
BRIDGE_PID=$!
sleep 0.4

STAMP="$(date +%s)"
CLIENT_ID="v3-client-${STAMP}"
EMAIL="v3${STAMP}@example.com"
PASS="Password123abc"

echo "GET /api/v3/security/csrf/${CLIENT_ID}"
CSRF="$(curl -sS "${BRIDGE_BASE}/api/v3/security/csrf/${CLIENT_ID}" | sed -n 's/.*"token":"\([^"]*\)".*/\1/p')"
if [[ -z "${CSRF}" ]]; then
  echo "FAIL: csrf token missing"
  exit 1
fi

echo "POST /api/v3/auth/signup"
SIGNUP_RES="$(curl -sS -X POST "${BRIDGE_BASE}/api/v3/auth/signup" \
  -H "Content-Type: application/json" \
  -H "x-client-id: ${CLIENT_ID}" \
  -H "x-csrf-token: ${CSRF}" \
  -d "{\"email\":\"${EMAIL}\",\"password\":\"${PASS}\"}")"
echo "${SIGNUP_RES}" | grep -q '"ok":true' || { echo "FAIL: signup failed"; echo "${SIGNUP_RES}"; exit 1; }

echo "POST /api/v3/auth/login"
LOGIN_RES="$(curl -sS -X POST "${BRIDGE_BASE}/api/v3/auth/login" \
  -H "Content-Type: application/json" \
  -H "x-client-id: ${CLIENT_ID}" \
  -H "x-csrf-token: ${CSRF}" \
  -d "{\"email\":\"${EMAIL}\",\"password\":\"${PASS}\"}")"
echo "${LOGIN_RES}" | grep -q '"ok":true' || { echo "FAIL: login failed"; echo "${LOGIN_RES}"; exit 1; }

echo "PASS: v3 JSON/header smoke completed"
