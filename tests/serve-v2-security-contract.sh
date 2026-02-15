#!/usr/bin/env bash
set -euo pipefail

# Security-specific contract checks for native serve.v2 fixture routes:
#   POST /__servev2/secure/:id
#   POST /__servev2/lockout/:subject
#
# Usage:
#   SERVE_V2_BASE=http://localhost:19010 bash tests/serve-v2-security-contract.sh

BASE="${SERVE_V2_BASE:-http://localhost:19010}"

fail() {
  echo "FAIL: $*"
  exit 1
}

json_field() {
  local json_text="$1"
  local key="$2"
  python3 - "$key" "$json_text" <<'PY'
import json,sys
key=sys.argv[1]
obj=json.loads(sys.argv[2])
cur=obj
for part in key.split("."):
    if isinstance(cur, dict) and part in cur:
        cur=cur[part]
    else:
        print("")
        raise SystemExit(0)
if isinstance(cur, bool):
    print("true" if cur else "false")
elif cur is None:
    print("null")
else:
    print(str(cur))
PY
}

echo "Checking secure route CSRF/role enforcement"
SEC_NO_CSRF="$(curl -sS -i -X POST "${BASE}/__servev2/secure/abc123" \
  -H 'Content-Type: application/json' \
  -H 'X-Role: admin' \
  -d '{}')"
printf '%s' "${SEC_NO_CSRF}" | grep -Eiq '^HTTP/[0-9.]+ 400' || fail "secure route without csrf did not return 400"
printf '%s' "${SEC_NO_CSRF}" | grep -Eq '"code"[[:space:]]*:[[:space:]]*"invalid_csrf"' || fail "secure route missing invalid_csrf code"

SEC_NOT_ADMIN="$(curl -sS -i -X POST "${BASE}/__servev2/secure/abc123" \
  -H 'Content-Type: application/json' \
  -H 'X-CSRF-Token: tok-1' \
  -H 'X-Role: user' \
  -d '{}')"
printf '%s' "${SEC_NOT_ADMIN}" | grep -Eiq '^HTTP/[0-9.]+ 403' || fail "secure route non-admin did not return 403"
printf '%s' "${SEC_NOT_ADMIN}" | grep -Eq '"code"[[:space:]]*:[[:space:]]*"forbidden"' || fail "secure route missing forbidden code"

SEC_ADMIN="$(curl -sS -X POST "${BASE}/__servev2/secure/abc123" \
  -H 'Content-Type: application/json' \
  -H 'X-CSRF-Token: tok-1' \
  -H 'X-Role: admin' \
  -d '{}')"
[[ "$(json_field "${SEC_ADMIN}" 'ok')" == "true" ]] || fail "secure route admin request failed"

echo "Checking lockout/rate limit behavior"
LOCK1="$(curl -sS -i -X POST "${BASE}/__servev2/lockout/test-user" -H 'Content-Type: application/json' -d '{}')"
printf '%s' "${LOCK1}" | grep -Eiq '^HTTP/[0-9.]+ 401' || fail "lockout attempt #1 did not return 401"
LOCK2="$(curl -sS -i -X POST "${BASE}/__servev2/lockout/test-user" -H 'Content-Type: application/json' -d '{}')"
printf '%s' "${LOCK2}" | grep -Eiq '^HTTP/[0-9.]+ 401' || fail "lockout attempt #2 did not return 401"
LOCK3="$(curl -sS -i -X POST "${BASE}/__servev2/lockout/test-user" -H 'Content-Type: application/json' -d '{}')"
printf '%s' "${LOCK3}" | grep -Eiq '^HTTP/[0-9.]+ 429' || fail "lockout attempt #3 did not return 429"
printf '%s' "${LOCK3}" | grep -Eq '"code"[[:space:]]*:[[:space:]]*"rate_limited"' || fail "lockout missing rate_limited code"

echo "PASS: serve.v2 security contract checks passed"
