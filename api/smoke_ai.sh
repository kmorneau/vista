#!/usr/bin/env bash
set -euo pipefail

PORT="${API_PORT:-19121}"
ROOT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
SERVER_LOG="${SERVER_LOG:-/tmp/vista_ai_smoke_server.log}"
BASE_URL="http://localhost:${PORT}"

SERVER_PID=""

cleanup() {
  if [[ -n "${SERVER_PID}" ]] && kill -0 "${SERVER_PID}" 2>/dev/null; then
    kill "${SERVER_PID}" >/dev/null 2>&1 || true
    wait "${SERVER_PID}" 2>/dev/null || true
  fi
}
trap cleanup EXIT

fail() {
  echo "FAIL: $1"
  echo "Server log: ${SERVER_LOG}"
  exit 1
}

assert_contains() {
  local haystack="$1"
  local needle="$2"
  local label="$3"
  if [[ "${haystack}" == *"${needle}"* ]]; then
    echo "PASS: ${label}"
  else
    echo "Response was:"
    echo "${haystack}"
    fail "${label}"
  fi
}

echo "Starting API on port ${PORT}..."
(cd "${ROOT_DIR}" && API_PORT="${PORT}" arturo api/server.art >"${SERVER_LOG}" 2>&1) &
SERVER_PID="$!"
sleep 1

if ! kill -0 "${SERVER_PID}" 2>/dev/null; then
  cat "${SERVER_LOG}" || true
  fail "API server failed to start"
fi

providers="$(curl -fsS "${BASE_URL}/api/ai/providers")"
assert_contains "${providers}" "\"openai\"" "providers include openai"
assert_contains "${providers}" "\"gemini\"" "providers include gemini"
assert_contains "${providers}" "\"echo\"" "providers include echo"
if [[ "${providers}" == *"\"kilo\""* ]]; then
  fail "providers should not include kilo"
else
  echo "PASS: providers exclude kilo"
fi

echo_basic="$(curl -fsS -X POST "${BASE_URL}/api/ai/chat/echo/echo-v1/0.4/hello%20vista")"
assert_contains "${echo_basic}" "\"ok\": true" "echo basic returns ok"
assert_contains "${echo_basic}" "echo: hello vista" "echo basic text"

echo_opts="$(curl -fsS -X POST "${BASE_URL}/api/ai/chat/echo/echo-v1/0.4/0.9/32/hello%20options")"
assert_contains "${echo_opts}" "\"top_p\": 0.9" "options route includes top_p"
assert_contains "${echo_opts}" "\"max_tokens\": 32" "options route includes max_tokens"

unsupported="$(curl -fsS -X POST "${BASE_URL}/api/ai/chat/kilo/kilo-chat-1/0.4/ping")"
assert_contains "${unsupported}" "\"ok\": false" "kilo request rejected"
assert_contains "${unsupported}" "Unsupported provider" "kilo returns unsupported provider"

validation="$(curl -fsS -X POST "${BASE_URL}/api/ai/chat/echo/echo-v1/0.4/1.9/0/bad")"
assert_contains "${validation}" "\"ok\": false" "validation error returns failure"
assert_contains "${validation}" "options.max_tokens" "validation includes max_tokens error"
assert_contains "${validation}" "options.top_p" "validation includes top_p error"

missing_openai_key="$(curl -fsS -X POST "${BASE_URL}/api/ai/chat/openai/gpt-4o-mini/0.2/hello")"
assert_contains "${missing_openai_key}" "Missing API key for provider" "openai key missing check"

if [[ -n "${OPENAI_API_KEY:-}" ]]; then
  echo "Running live OpenAI check..."
  cleanup
  (cd "${ROOT_DIR}" && API_PORT="${PORT}" OPENAI_API_KEY="${OPENAI_API_KEY}" arturo api/server.art >"${SERVER_LOG}" 2>&1) &
  SERVER_PID="$!"
  sleep 1
  if ! kill -0 "${SERVER_PID}" 2>/dev/null; then
    cat "${SERVER_LOG}" || true
    fail "API server failed to restart for live OpenAI check"
  fi

  openai_resp="$(curl -fsS -X POST "${BASE_URL}/api/ai/chat/openai/gpt-4o-mini/0.2/0.9/16/Reply%20exactly%20vista-ok")"
  assert_contains "${openai_resp}" "\"ok\": true" "openai live route returns ok"
  assert_contains "${openai_resp}" "\"text\": \"vista-ok\"" "openai live route content"
else
  echo "SKIP: live OpenAI check (set OPENAI_API_KEY to enable)"
fi

echo "All AI smoke checks passed."
