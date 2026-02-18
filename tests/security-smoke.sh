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
API_PORT="${API_PORT:-19169}"
BASE_URL="${BASE_URL:-http://localhost:${API_PORT}}"

b64url_json() {
  local json="${1}"
  PAYLOAD="${json}" python3 -c 'import os,base64; raw=os.environ["PAYLOAD"].encode("utf-8"); print(base64.urlsafe_b64encode(raw).decode("ascii").rstrip("="))'
}

cleanup() {
  if [[ -n "${SERVER_PID:-}" ]]; then
    kill "$SERVER_PID" >/dev/null 2>&1 || true
    wait "$SERVER_PID" 2>/dev/null || true
  fi
  rm -f "$DB_FILE"
}
trap cleanup EXIT

API_DB_NAME="$DB_NAME" API_PORT="${API_PORT}" "${ARTURO_BIN}" api/server.art >/tmp/vista_api_server.log 2>&1 &
SERVER_PID=$!

for _ in $(seq 1 40); do
  if curl -sS "${BASE_URL}/api/health" >/dev/null 2>&1; then
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

SIGNUP_PAYLOAD="$(b64url_json "{\"email\":\"${EMAIL}\",\"password\":\"${PASS}\"}")"
SIGNUP="$(curl -sS -X POST "${BASE_URL}/api/v2/auth/signup/${CLIENT_ID}/${CSRF}/${SIGNUP_PAYLOAD}")"
echo "${SIGNUP}" | grep -Eq '"ok"[[:space:]]*:[[:space:]]*true' || { echo "FAIL: v2 signup failed"; echo "${SIGNUP}"; exit 1; }

LOGIN_PAYLOAD="$(b64url_json "{\"email\":\"${EMAIL}\",\"password\":\"${PASS}\"}")"
LOGIN="$(curl -sS -X POST "${BASE_URL}/api/v2/auth/login/${CLIENT_ID}/${CSRF}/${LOGIN_PAYLOAD}")"
echo "${LOGIN}" | grep -Eq '"ok"[[:space:]]*:[[:space:]]*true' || { echo "FAIL: v2 login failed"; echo "${LOGIN}"; exit 1; }

TOKEN="$(python3 -c 'import json,sys; print((json.loads(sys.stdin.read()).get("data") or {}).get("token",""))' <<<"${LOGIN}" | tr -d '\r\n')"
if [[ -z "${TOKEN}" ]]; then
  echo "FAIL: login token missing"
  echo "${LOGIN}"
  exit 1
fi

EMAIL_PAYLOAD="$(b64url_json "{\"token\":\"${TOKEN}\",\"email\":\"${EMAIL2}\"}")"
EMAIL_UPDATE="$(curl -sS -X PUT "${BASE_URL}/api/v2/auth/email/${CLIENT_ID}/${CSRF}/${EMAIL_PAYLOAD}")"
echo "${EMAIL_UPDATE}" | grep -Eq '"ok"[[:space:]]*:[[:space:]]*true' || { echo "FAIL: v2 email update failed"; echo "${EMAIL_UPDATE}"; exit 1; }
TOKEN2="$(python3 -c 'import json,sys; print((json.loads(sys.stdin.read()).get("data") or {}).get("token",""))' <<<"${EMAIL_UPDATE}" | tr -d '\r\n')"
if [[ -z "${TOKEN2}" || "${TOKEN2}" == "${TOKEN}" ]]; then
  echo "FAIL: rotated token missing after email update"
  echo "${EMAIL_UPDATE}"
  exit 1
fi
EMAIL_OLD_PAYLOAD="$(b64url_json "{\"token\":\"${TOKEN}\",\"email\":\"${EMAIL}\"}")"
EMAIL_OLD_CHECK="$(curl -sS -X PUT "${BASE_URL}/api/v2/auth/email/${CLIENT_ID}/${CSRF}/${EMAIL_OLD_PAYLOAD}")"
echo "${EMAIL_OLD_CHECK}" | grep -Eq '"code"[[:space:]]*:[[:space:]]*"unauthorized"' || { echo "FAIL: old token still valid after email update"; echo "${EMAIL_OLD_CHECK}"; exit 1; }

PASS_PAYLOAD="$(b64url_json "{\"token\":\"${TOKEN2}\",\"old_password\":\"${PASS}\",\"new_password\":\"${PASS2}\"}")"
PASS_UPDATE="$(curl -sS -X PUT "${BASE_URL}/api/v2/auth/password/${CLIENT_ID}/${CSRF}/${PASS_PAYLOAD}")"
echo "${PASS_UPDATE}" | grep -Eq '"ok"[[:space:]]*:[[:space:]]*true' || { echo "FAIL: v2 password update failed"; echo "${PASS_UPDATE}"; exit 1; }
TOKEN3="$(python3 -c 'import json,sys; print((json.loads(sys.stdin.read()).get("data") or {}).get("token",""))' <<<"${PASS_UPDATE}" | tr -d '\r\n')"
if [[ -z "${TOKEN3}" || "${TOKEN3}" == "${TOKEN2}" ]]; then
  echo "FAIL: rotated token missing after password update"
  echo "${PASS_UPDATE}"
  exit 1
fi
PASS_OLD_PAYLOAD="$(b64url_json "{\"token\":\"${TOKEN2}\",\"old_password\":\"${PASS2}\",\"new_password\":\"${PASS}\"}")"
PASS_OLD_CHECK="$(curl -sS -X PUT "${BASE_URL}/api/v2/auth/password/${CLIENT_ID}/${CSRF}/${PASS_OLD_PAYLOAD}")"
echo "${PASS_OLD_CHECK}" | grep -Eq '"code"[[:space:]]*:[[:space:]]*"unauthorized"' || { echo "FAIL: old token still valid after password update"; echo "${PASS_OLD_CHECK}"; exit 1; }
AUDIT_FORBIDDEN="$(curl -sS -X GET "${BASE_URL}/api/security/audit/${TOKEN3}/5")"
echo "${AUDIT_FORBIDDEN}" | grep -Eq '"code"[[:space:]]*:[[:space:]]*"forbidden"' || { echo "FAIL: security admin guard failed (audit)"; echo "${AUDIT_FORBIDDEN}"; exit 1; }
RUNTIME_FORBIDDEN="$(curl -sS -X POST "${BASE_URL}/api/security/runtime/clear/${TOKEN3}")"
echo "${RUNTIME_FORBIDDEN}" | grep -Eq '"code"[[:space:]]*:[[:space:]]*"forbidden"' || { echo "FAIL: security admin guard failed (runtime clear)"; echo "${RUNTIME_FORBIDDEN}"; exit 1; }

LOGOUT_PAYLOAD="$(b64url_json "{\"token\":\"${TOKEN3}\"}")"
LOGOUT_OK="$(curl -sS -X POST "${BASE_URL}/api/v2/auth/logout/${CLIENT_ID}/${CSRF}/${LOGOUT_PAYLOAD}")"
echo "${LOGOUT_OK}" | grep -Eq '"ok"[[:space:]]*:[[:space:]]*true' || { echo "FAIL: rotated token not valid for logout"; echo "${LOGOUT_OK}"; exit 1; }

BAD_CSRF="$(curl -sS -X POST "${BASE_URL}/api/v2/auth/login/${CLIENT_ID}/badcsrf/${LOGIN_PAYLOAD}")"
echo "${BAD_CSRF}" | grep -Eq '"code"[[:space:]]*:[[:space:]]*"invalid_csrf"' || { echo "FAIL: csrf mismatch not enforced"; echo "${BAD_CSRF}"; exit 1; }

echo "PASS: security smoke completed"
