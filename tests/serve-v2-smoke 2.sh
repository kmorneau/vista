#!/usr/bin/env bash
set -euo pipefail

ROOT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
BACKEND_PORT="${BACKEND_PORT:-19141}"
SERVE_V2_PORT="${SERVE_V2_PORT:-19142}"

BACKEND_LOG="${BACKEND_LOG:-/tmp/vista_servev2_backend.log}"
SERVE_V2_LOG="${SERVE_V2_LOG:-/tmp/vista_servev2.log}"

cleanup() {
  [[ -n "${SERVE_V2_PID:-}" ]] && kill "${SERVE_V2_PID}" >/dev/null 2>&1 || true
  [[ -n "${BACKEND_PID:-}" ]] && kill "${BACKEND_PID}" >/dev/null 2>&1 || true
}
trap cleanup EXIT

echo "Starting backend API on :${BACKEND_PORT}"
(cd "${ROOT_DIR}" && API_PORT="${BACKEND_PORT}" arturo api/server.art >"${BACKEND_LOG}" 2>&1) &
BACKEND_PID=$!
sleep 0.8

echo "Starting Arturo serve_v2 adapter on :${SERVE_V2_PORT}"
(cd "${ROOT_DIR}" && API_BACKEND_BASE="http://localhost:${BACKEND_PORT}" API_V3_PORT="${SERVE_V2_PORT}" arturo api/serve_v2.art >"${SERVE_V2_LOG}" 2>&1) &
SERVE_V2_PID=$!

READY=0
for _ in {1..40}; do
  if curl -sS "http://localhost:${SERVE_V2_PORT}/__servev2/health" >/dev/null 2>&1; then
    READY=1
    break
  fi
  sleep 0.2
done
if [[ "${READY}" != "1" ]]; then
  echo "FAIL: serve.v2 adapter did not become ready"
  sed -n '1,120p' "${SERVE_V2_LOG}" || true
  exit 1
fi

echo "Running serve.v2 contract checks"
SERVE_V2_BASE="http://localhost:${SERVE_V2_PORT}" bash "${ROOT_DIR}/tests/serve-v2-contract.sh"
echo "PASS: serve.v2 smoke completed"
