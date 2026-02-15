#!/usr/bin/env bash
set -euo pipefail

# Contract smoke for serve.v2 implementations.
# Expects a running server that implements the following test routes:
#   GET  /__servev2/health
#   POST /__servev2/echo/:id
# Behavior expectations:
#   - reads query params, headers, route params, JSON body
#   - lowercases header keys
#   - rejects invalid JSON with 400 invalid_json
#   - rejects oversized body with 413 payload_too_large
#
# Usage:
#   SERVE_V2_BASE=http://localhost:19010 bash tests/serve-v2-contract.sh

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

echo "Checking health at ${BASE}/__servev2/health"
HEALTH="$(curl -sS "${BASE}/__servev2/health" || true)"
[[ -n "${HEALTH}" ]] || fail "health endpoint not reachable"
[[ "$(json_field "${HEALTH}" 'ok')" == "true" ]] || fail "health ok=false"

echo "Checking echo route with JSON body + headers + params + query"
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

echo "Checking invalid JSON rejection"
INVALID_RAW="$(curl -sS -i -X POST "${BASE}/__servev2/echo/zzz" \
  -H 'Content-Type: application/json' \
  --data-binary '{"email":"broken"')"
printf '%s' "${INVALID_RAW}" | grep -q " 400 " || fail "invalid json did not return 400"
printf '%s' "${INVALID_RAW}" | grep -q '"code":"invalid_json"' || fail "invalid_json error code missing"

echo "Checking payload limit rejection"
BIG_FILE="$(mktemp)"
python3 - "${BIG_FILE}" <<'PY'
import sys
path=sys.argv[1]
with open(path,"w",encoding="utf-8") as f:
    f.write('{"blob":"' + ('x'*1200000) + '"}')
PY
LARGE_RAW="$(curl -sS -i -X POST "${BASE}/__servev2/echo/large" \
  -H 'Content-Type: application/json' \
  --data-binary "@${BIG_FILE}")"
rm -f "${BIG_FILE}"
printf '%s' "${LARGE_RAW}" | grep -q " 413 " || fail "large payload did not return 413"
printf '%s' "${LARGE_RAW}" | grep -q '"code":"payload_too_large"' || fail "payload_too_large error code missing"

echo "PASS: serve.v2 contract checks passed"
