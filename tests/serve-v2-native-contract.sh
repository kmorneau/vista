#!/usr/bin/env bash
set -euo pipefail

# Contract checks for native serve.v2 fixture behavior:
#   GET  /__servev2/health
#   POST /__servev2/echo/:id
#
# Usage:
#   SERVE_V2_BASE=http://localhost:19010 bash tests/serve-v2-native-contract.sh

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

echo "Checking native health at ${BASE}/__servev2/health"
HEALTH="$(curl -sS "${BASE}/__servev2/health" || true)"
[[ -n "${HEALTH}" ]] || fail "health endpoint not reachable"
[[ "$(json_field "${HEALTH}" 'ok')" == "true" ]] || fail "health ok=false"

echo "Checking native echo route with JSON body + headers + params + query"
ECHO="$(curl -sS -X POST "${BASE}/__servev2/echo/abc123?mode=test" \
  -H 'Content-Type: application/json' \
  -H 'X-CSRF-Token: tok-1' \
  -H 'X-Client-ID: cli-9' \
  -d '{"email":"a@example.com","password":"Password123abc"}')"

[[ "$(json_field "${ECHO}" 'ok')" == "true" ]] || fail "echo ok=false"
[[ "$(json_field "${ECHO}" 'data.params.id')" == "abc123" ]] || fail "route param not mapped"
[[ "$(json_field "${ECHO}" 'data.query.mode')" == "test" ]] || fail "query not mapped"
[[ "$(json_field "${ECHO}" 'data.headers.x-csrf-token')" == "tok-1" ]] || fail "header read failed"
[[ "$(json_field "${ECHO}" 'data.headers.x-client-id')" == "cli-9" ]] || fail "header lowercase map failed"
[[ "$(json_field "${ECHO}" 'data.body_json.email')" == "a@example.com" ]] || fail "body_json parse failed"

echo "PASS: native serve.v2 contract checks passed"
