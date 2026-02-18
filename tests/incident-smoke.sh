#!/usr/bin/env bash
set -euo pipefail

ROOT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
cd "$ROOT_DIR"

ARTURO_BIN="${ARTURO_BIN:-}"
if [[ -z "${ARTURO_BIN}" ]]; then
  if [[ -x "${ROOT_DIR}/../arturo/bin/arturo" ]]; then
    ARTURO_BIN="${ROOT_DIR}/../arturo/bin/arturo"
  else
    ARTURO_BIN="arturo"
  fi
fi

DB_NAME="vista_api_incident_$(date +%s)"
DB_FILE="${DB_NAME}.graf"
API_PORT="${API_PORT:-19169}"
BASE_URL="${BASE_URL:-http://localhost:${API_PORT}}"

b64url_json() {
  local json="${1}"
  PAYLOAD="${json}" python3 -c 'import os,base64; raw=os.environ["PAYLOAD"].encode("utf-8"); print(base64.urlsafe_b64encode(raw).decode("ascii").rstrip("="))'
}

cleanup() {
  if [[ -n "${SERVER_PID:-}" ]]; then
    kill "${SERVER_PID}" >/dev/null 2>&1 || true
    wait "${SERVER_PID}" 2>/dev/null || true
  fi
  rm -f "${DB_FILE}"
}
trap cleanup EXIT

API_DB_NAME="${DB_NAME}" API_PORT="${API_PORT}" "${ARTURO_BIN}" api/server.art >/tmp/vista_api_incident.log 2>&1 &
SERVER_PID=$!

for _ in $(seq 1 80); do
  if curl -sS "${BASE_URL}/api/health" >/dev/null 2>&1; then
    break
  fi
  sleep 0.25
done

STAMP="$(date +%s)"
CLIENT_ID="incident-client-${STAMP}"
EMAIL="incident${STAMP}@example.com"
PASS="Password123abc"

CSRF_RAW="$(curl -sS "${BASE_URL}/api/v2/security/csrf/${CLIENT_ID}")"
CSRF="$(python3 -c 'import json,sys; print(json.loads(sys.stdin.read())["data"]["token"])' <<<"${CSRF_RAW}" | tr -d '\r\n')"
[[ -n "${CSRF}" ]] || { echo "FAIL: csrf token missing"; exit 1; }

SIGNUP_PAYLOAD="$(b64url_json "{\"email\":\"${EMAIL}\",\"password\":\"${PASS}\"}")"
SIGNUP="$(curl -sS -X POST "${BASE_URL}/api/v2/auth/signup/${CLIENT_ID}/${CSRF}/${SIGNUP_PAYLOAD}")"
echo "${SIGNUP}" | grep -Eq '"ok"[[:space:]]*:[[:space:]]*true' || { echo "FAIL: signup failed"; echo "${SIGNUP}"; exit 1; }

LOGIN_PAYLOAD="$(b64url_json "{\"email\":\"${EMAIL}\",\"password\":\"${PASS}\"}")"
LOGIN="$(curl -sS -X POST "${BASE_URL}/api/v2/auth/login/${CLIENT_ID}/${CSRF}/${LOGIN_PAYLOAD}")"
TOKEN="$(python3 -c 'import json,sys; print((json.loads(sys.stdin.read()).get("data") or {}).get("token",""))' <<<"${LOGIN}" | tr -d '\r\n')"
[[ -n "${TOKEN}" ]] || { echo "FAIL: login token missing"; echo "${LOGIN}"; exit 1; }

AUDIT_FORBIDDEN="$(curl -sS -X GET "${BASE_URL}/api/security/audit/${TOKEN}/10")"
echo "${AUDIT_FORBIDDEN}" | grep -Eq '"code"[[:space:]]*:[[:space:]]*"forbidden"' || { echo "FAIL: non-admin audit guard failed"; echo "${AUDIT_FORBIDDEN}"; exit 1; }

RUNTIME_FORBIDDEN="$(curl -sS -X POST "${BASE_URL}/api/security/runtime/clear/${TOKEN}")"
echo "${RUNTIME_FORBIDDEN}" | grep -Eq '"code"[[:space:]]*:[[:space:]]*"forbidden"' || { echo "FAIL: non-admin runtime clear guard failed"; echo "${RUNTIME_FORBIDDEN}"; exit 1; }

LOGOUT_PAYLOAD="$(b64url_json "{\"token\":\"${TOKEN}\"}")"
LOGOUT="$(curl -sS -X POST "${BASE_URL}/api/v2/auth/logout/${CLIENT_ID}/${CSRF}/${LOGOUT_PAYLOAD}")"
echo "${LOGOUT}" | grep -Eq '"ok"[[:space:]]*:[[:space:]]*true' || { echo "FAIL: logout failed"; echo "${LOGOUT}"; exit 1; }

EMAIL_AFTER_LOGOUT_PAYLOAD="$(b64url_json "{\"token\":\"${TOKEN}\",\"email\":\"postlogout@example.com\"}")"
EMAIL_AFTER_LOGOUT="$(curl -sS -X PUT "${BASE_URL}/api/v2/auth/email/${CLIENT_ID}/${CSRF}/${EMAIL_AFTER_LOGOUT_PAYLOAD}")"
echo "${EMAIL_AFTER_LOGOUT}" | grep -Eq '"code"[[:space:]]*:[[:space:]]*"unauthorized"' || { echo "FAIL: logout did not invalidate session"; echo "${EMAIL_AFTER_LOGOUT}"; exit 1; }

echo "PASS: incident smoke completed"
