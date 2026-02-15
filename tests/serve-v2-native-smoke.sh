#!/usr/bin/env bash
set -euo pipefail

ROOT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
SERVE_V2_PORT="${SERVE_V2_PORT:-19010}"
SERVE_V2_LOG="${SERVE_V2_LOG:-/tmp/vista_servev2_native.log}"
ARTURO_BIN="${ARTURO_BIN:-}"
if [[ -z "${ARTURO_BIN}" ]]; then
  if [[ -x "${ROOT_DIR}/../arturo/bin/arturo" ]]; then
    ARTURO_BIN="${ROOT_DIR}/../arturo/bin/arturo"
  else
    ARTURO_BIN="arturo"
  fi
fi

cleanup() {
  [[ -n "${SERVE_V2_PID:-}" ]] && kill "${SERVE_V2_PID}" >/dev/null 2>&1 || true
  [[ -n "${SERVE_V2_PID:-}" ]] && wait "${SERVE_V2_PID}" 2>/dev/null || true
}
trap cleanup EXIT

echo "Starting native serve.v2 fixture on :${SERVE_V2_PORT}"
(cd "${ROOT_DIR}" && "${ARTURO_BIN}" tests/serve-v2-fixture.art >"${SERVE_V2_LOG}" 2>&1) &
SERVE_V2_PID=$!

READY=0
for _ in {1..60}; do
  if curl -sS "http://localhost:${SERVE_V2_PORT}/__servev2/health" >/dev/null 2>&1; then
    READY=1
    break
  fi
  sleep 0.2
done
if [[ "${READY}" != "1" ]]; then
  echo "FAIL: native serve.v2 fixture did not become ready"
  sed -n '1,160p' "${SERVE_V2_LOG}" || true
  exit 1
fi

echo "Running native serve.v2 contract checks"
SERVE_V2_BASE="http://localhost:${SERVE_V2_PORT}" bash "${ROOT_DIR}/tests/serve-v2-native-contract.sh"
SERVE_V2_BASE="http://localhost:${SERVE_V2_PORT}" bash "${ROOT_DIR}/tests/serve-v2-security-contract.sh"
echo "PASS: native serve.v2 smoke completed"
