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

DB_NAME="vista_api_smoke_$(date +%s)"
DB_FILE="${DB_NAME}.graf"
BASE_URL="${BASE_URL:-http://localhost:18969}"

cleanup() {
  if [[ -n "${SERVER_PID:-}" ]]; then
    kill "$SERVER_PID" >/dev/null 2>&1 || true
    wait "$SERVER_PID" 2>/dev/null || true
  fi
  rm -f "$DB_FILE"
}
trap cleanup EXIT

API_DB_NAME="$DB_NAME" "${ARTURO_BIN}" api/server.art >/tmp/vista_api_server.log 2>&1 &
SERVER_PID=$!

for _ in $(seq 1 40); do
  if curl -sS http://localhost:18969/api/health >/dev/null 2>&1; then
    break
  fi
  sleep 0.25
done

STAMP="$(date +%s)"
CLIENT_ID="sec-client-${STAMP}"
EMAIL="sec${STAMP}@example.com"
PASS="Password123abc"
PASS2="Password456xyz"
EMAIL2="sec${STAMP}_new@example.com"

CSRF_RAW="$(curl -sS "${BASE_URL}/api/v2/security/csrf/${CLIENT_ID}")"
CSRF="$(python3 -c 'import json,sys; print(json.loads(sys.stdin.read())["data"]["token"])' <<<"${CSRF_RAW}" | tr -d '\r\n')"
if [[ -z "${CSRF}" ]]; then
  echo "FAIL: csrf token missing"
  echo "${CSRF_RAW}"
  exit 1
fi

SIGNUP="$(curl -sS -X POST "${BASE_URL}/api/v2/auth/signup" \
  -H 'Content-Type: application/json' \
  -H "x-client-id: ${CLIENT_ID}" \
  -H "x-csrf-token: ${CSRF}" \
  -d "{\"email\":\"${EMAIL}\",\"password\":\"${PASS}\"}")"
echo "${SIGNUP}" | grep -Eq '"ok"[[:space:]]*:[[:space:]]*true' || { echo "FAIL: v2 signup failed"; echo "${SIGNUP}"; exit 1; }

LOGIN="$(curl -sS -X POST "${BASE_URL}/api/v2/auth/login" \
  -H 'Content-Type: application/json' \
  -H "x-client-id: ${CLIENT_ID}" \
  -H "x-csrf-token: ${CSRF}" \
  -d "{\"email\":\"${EMAIL}\",\"password\":\"${PASS}\"}")"
echo "${LOGIN}" | grep -Eq '"ok"[[:space:]]*:[[:space:]]*true' || { echo "FAIL: v2 login failed"; echo "${LOGIN}"; exit 1; }

TOKEN="$(python3 -c 'import json,sys; print((json.loads(sys.stdin.read()).get("data") or {}).get("token",""))' <<<"${LOGIN}" | tr -d '\r\n')"
if [[ -z "${TOKEN}" ]]; then
  echo "FAIL: login token missing"
  echo "${LOGIN}"
  exit 1
fi

EMAIL_UPDATE="$(curl -sS -X PUT "${BASE_URL}/api/v2/auth/email" \
  -H 'Content-Type: application/json' \
  -H "x-client-id: ${CLIENT_ID}" \
  -H "x-csrf-token: ${CSRF}" \
  -d "{\"token\":\"${TOKEN}\",\"email\":\"${EMAIL2}\"}")"
echo "${EMAIL_UPDATE}" | grep -Eq '"ok"[[:space:]]*:[[:space:]]*true' || { echo "FAIL: v2 email update failed"; echo "${EMAIL_UPDATE}"; exit 1; }
TOKEN2="$(python3 -c 'import json,sys; print((json.loads(sys.stdin.read()).get("data") or {}).get("token",""))' <<<"${EMAIL_UPDATE}" | tr -d '\r\n')"
if [[ -z "${TOKEN2}" || "${TOKEN2}" == "${TOKEN}" ]]; then
  echo "FAIL: rotated token missing after email update"
  echo "${EMAIL_UPDATE}"
  exit 1
fi
ME_OLD_1="$(curl -sS -X GET "${BASE_URL}/api/v2/auth/me" -H "x-auth-token: ${TOKEN}")"
echo "${ME_OLD_1}" | grep -Eq '"code"[[:space:]]*:[[:space:]]*"unauthorized"' || { echo "FAIL: old token still valid after email update"; echo "${ME_OLD_1}"; exit 1; }

PASS_UPDATE="$(curl -sS -X PUT "${BASE_URL}/api/v2/auth/password" \
  -H 'Content-Type: application/json' \
  -H "x-client-id: ${CLIENT_ID}" \
  -H "x-csrf-token: ${CSRF}" \
  -d "{\"token\":\"${TOKEN2}\",\"old_password\":\"${PASS}\",\"new_password\":\"${PASS2}\"}")"
echo "${PASS_UPDATE}" | grep -Eq '"ok"[[:space:]]*:[[:space:]]*true' || { echo "FAIL: v2 password update failed"; echo "${PASS_UPDATE}"; exit 1; }
TOKEN3="$(python3 -c 'import json,sys; print((json.loads(sys.stdin.read()).get("data") or {}).get("token",""))' <<<"${PASS_UPDATE}" | tr -d '\r\n')"
if [[ -z "${TOKEN3}" || "${TOKEN3}" == "${TOKEN2}" ]]; then
  echo "FAIL: rotated token missing after password update"
  echo "${PASS_UPDATE}"
  exit 1
fi
ME_OLD_2="$(curl -sS -X GET "${BASE_URL}/api/v2/auth/me" -H "x-auth-token: ${TOKEN2}")"
echo "${ME_OLD_2}" | grep -Eq '"code"[[:space:]]*:[[:space:]]*"unauthorized"' || { echo "FAIL: old token still valid after password update"; echo "${ME_OLD_2}"; exit 1; }
ME_NEW="$(curl -sS -X GET "${BASE_URL}/api/v2/auth/me" -H "x-auth-token: ${TOKEN3}")"
echo "${ME_NEW}" | grep -Eq '"ok"[[:space:]]*:[[:space:]]*true' || { echo "FAIL: rotated token not valid"; echo "${ME_NEW}"; exit 1; }

CFG_FORBIDDEN="$(curl -sS -X GET "${BASE_URL}/api/v2/security/config" -H "x-auth-token: ${TOKEN3}")"
echo "${CFG_FORBIDDEN}" | grep -Eq '"code"[[:space:]]*:[[:space:]]*"forbidden"' || { echo "FAIL: v2 security admin guard failed"; echo "${CFG_FORBIDDEN}"; exit 1; }

BAD_CSRF="$(curl -sS -X POST "${BASE_URL}/api/v2/auth/login" \
  -H 'Content-Type: application/json' \
  -H "x-client-id: ${CLIENT_ID}" \
  -H "x-csrf-token: badcsrf" \
  -d "{\"email\":\"${EMAIL}\",\"password\":\"${PASS}\"}")"
echo "${BAD_CSRF}" | grep -Eq '"code"[[:space:]]*:[[:space:]]*"invalid_csrf"' || { echo "FAIL: csrf mismatch not enforced"; echo "${BAD_CSRF}"; exit 1; }

echo "PASS: security smoke completed"
