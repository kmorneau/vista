#!/usr/bin/env bash
set -euo pipefail

ROOT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
ARTURO_BIN="${ARTURO_BIN:-}"
if [[ -z "${ARTURO_BIN}" ]]; then
  if [[ -x "${ROOT_DIR}/../arturo/bin/arturo" ]]; then
    ARTURO_BIN="${ROOT_DIR}/../arturo/bin/arturo"
  else
    ARTURO_BIN="arturo"
  fi
fi

echo "Running native Arturo serve.v2 smoke suite"
ARTURO_BIN="${ARTURO_BIN}" bash "${ROOT_DIR}/tests/serve-v2-native-smoke.sh"
