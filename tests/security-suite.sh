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

echo "Running security/API suite with ARTURO_BIN=${ARTURO_BIN}"
ARTURO_BIN="${ARTURO_BIN}" bash tests/serve-v2-smoke.sh
ARTURO_BIN="${ARTURO_BIN}" bash tests/security-smoke.sh
ARTURO_BIN="${ARTURO_BIN}" bash tests/api-smoke.sh
ARTURO_BIN="${ARTURO_BIN}" bash tests/incident-smoke.sh
echo "PASS: security/API suite completed"
