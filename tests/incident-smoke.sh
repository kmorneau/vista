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
BASE_URL="${BASE_URL:-http://localhost:18969}"
BOOTSTRAP_SECRET="${SECURITY_BOOTSTRAP_SECRET:-vista-bootstrap-dev-secret}"

cleanup() {
  if [[ -n "${SERVER_PID:-}" ]]; then
    kill "${SERVER_PID}" >/dev/null 2>&1 || true
    wait "${SERVER_PID}" 2>/dev/null || true
  fi
  rm -f "${DB_FILE}"
}
trap cleanup EXIT

API_DB_NAME="${DB_NAME}" "${ARTURO_BIN}" api/server.art >/tmp/vista_api_incident.log 2>&1 &
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

SIGNUP="$(curl -sS -X POST "${BASE_URL}/api/v2/auth/signup" \
  -H 'Content-Type: application/json' \
  -H "x-client-id: ${CLIENT_ID}" \
  -H "x-csrf-token: ${CSRF}" \
  -d "{\"email\":\"${EMAIL}\",\"password\":\"${PASS}\"}")"
echo "${SIGNUP}" | grep -Eq '"ok"[[:space:]]*:[[:space:]]*true' || { echo "FAIL: signup failed"; echo "${SIGNUP}"; exit 1; }

BOOT="$(curl -sS -X POST "${BASE_URL}/api/v2/auth/bootstrap" \
  -H 'Content-Type: application/json' \
  -H "x-client-id: ${CLIENT_ID}" \
  -H "x-csrf-token: ${CSRF}" \
  -d "{\"secret\":\"${BOOTSTRAP_SECRET}\",\"email\":\"${EMAIL}\"}")"
echo "${BOOT}" | grep -Eq '"ok"[[:space:]]*:[[:space:]]*true' || { echo "FAIL: bootstrap failed"; echo "${BOOT}"; exit 1; }

LOGIN="$(curl -sS -X POST "${BASE_URL}/api/v2/auth/login" \
  -H 'Content-Type: application/json' \
  -H "x-client-id: ${CLIENT_ID}" \
  -H "x-csrf-token: ${CSRF}" \
  -d "{\"email\":\"${EMAIL}\",\"password\":\"${PASS}\"}")"
TOKEN="$(python3 -c 'import json,sys; print((json.loads(sys.stdin.read()).get("data") or {}).get("token",""))' <<<"${LOGIN}" | tr -d '\r\n')"
[[ -n "${TOKEN}" ]] || { echo "FAIL: login token missing"; echo "${LOGIN}"; exit 1; }

CFG1="$(curl -sS -X POST "${BASE_URL}/api/v2/security/config" \
  -H 'Content-Type: application/json' \
  -H "x-auth-token: ${TOKEN}" \
  -d '{"incident_disable_ai_providers":["echo"]}')"
echo "${CFG1}" | grep -Eq '"ok"[[:space:]]*:[[:space:]]*true' || { echo "FAIL: incident disable provider config failed"; echo "${CFG1}"; exit 1; }

ECHO_BLOCKED="$(curl -sS -X POST "${BASE_URL}/api/ai/chat/echo/echo-v1/0.2/hello")"
echo "${ECHO_BLOCKED}" | grep -Eq '"code"[[:space:]]*:[[:space:]]*"forbidden"' || { echo "FAIL: incident provider block not enforced"; echo "${ECHO_BLOCKED}"; exit 1; }

NOW_UNIX="$(date +%s)"
CFG2="$(curl -sS -X POST "${BASE_URL}/api/v2/security/config" \
  -H 'Content-Type: application/json' \
  -H "x-auth-token: ${TOKEN}" \
  -d "{\"incident_force_logout_before_unix\":${NOW_UNIX}}")"
echo "${CFG2}" | grep -Eq '"ok"[[:space:]]*:[[:space:]]*true' || { echo "FAIL: force logout config failed"; echo "${CFG2}"; exit 1; }

ME_AFTER="$(curl -sS -X GET "${BASE_URL}/api/v2/auth/me" -H "x-auth-token: ${TOKEN}")"
echo "${ME_AFTER}" | grep -Eq '"code"[[:space:]]*:[[:space:]]*"unauthorized"' || { echo "FAIL: force logout did not invalidate session"; echo "${ME_AFTER}"; exit 1; }

echo "PASS: incident smoke completed"
