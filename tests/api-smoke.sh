#!/usr/bin/env bash
set -euo pipefail

ROOT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
cd "${ROOT_DIR}"

ARTURO_BIN="${ARTURO_BIN:-}"
if [[ -z "${ARTURO_BIN}" ]]; then
  if [[ -x "${ROOT_DIR}/../arturo/bin/arturo" ]]; then
    ARTURO_BIN="${ROOT_DIR}/../arturo/bin/arturo"
  else
    ARTURO_BIN="arturo"
  fi
fi

API_PORT="${API_PORT:-18969}"
BASE_URL="${BASE_URL:-http://localhost:${API_PORT}}"
DB_NAME="vista_api_smoke_$(date +%s)"
DB_FILE="${DB_NAME}.graf"
SERVER_LOG="${SERVER_LOG:-/tmp/vista_api_smoke.log}"

cleanup() {
  if [[ -n "${SERVER_PID:-}" ]]; then
    kill "${SERVER_PID}" >/dev/null 2>&1 || true
    wait "${SERVER_PID}" 2>/dev/null || true
  fi
  rm -f "${DB_FILE}"
}
trap cleanup EXIT

API_DB_NAME="${DB_NAME}" API_PORT="${API_PORT}" "${ARTURO_BIN}" api/server.art >"${SERVER_LOG}" 2>&1 &
SERVER_PID=$!

READY=0
for _ in $(seq 1 80); do
  if curl -sS "${BASE_URL}/api/health" >/dev/null 2>&1; then
    READY=1
    break
  fi
  sleep 0.25
done

if [[ "${READY}" != "1" ]]; then
  echo "FAIL: API server did not become ready at ${BASE_URL}"
  sed -n '1,200p' "${SERVER_LOG}" || true
  exit 1
fi

"${ARTURO_BIN}" tests/api-smoke.art "--base=${BASE_URL}"
echo "PASS: api smoke completed"
