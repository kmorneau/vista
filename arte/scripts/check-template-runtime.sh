#!/usr/bin/env bash
set -euo pipefail

REPO_ROOT="$(cd "$(dirname "${BASH_SOURCE[0]}")/../.." && pwd)"
cd "$REPO_ROOT"

bash arte/scripts/sync-template-runtime.sh

if ! git diff --quiet -- \
  arte/apps/_template/ui/vista.art \
  arte/apps/_template/ui/src/vista \
  arte/apps/_template/ui/dist/assets/icons \
  arte/apps/_template/vendor/grafito/grafito.art; then
  echo "Template runtime drift detected."
  echo "Run: bash arte/scripts/sync-template-runtime.sh"
  git --no-pager diff -- \
    arte/apps/_template/ui/vista.art \
    arte/apps/_template/ui/src/vista \
    arte/apps/_template/ui/dist/assets/icons \
    arte/apps/_template/vendor/grafito/grafito.art
  exit 1
fi

echo "Template runtime is in sync."
