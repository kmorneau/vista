#!/usr/bin/env bash
set -euo pipefail

REPO_ROOT="$(cd "$(dirname "${BASH_SOURCE[0]}")/../.." && pwd)"
cd "$REPO_ROOT"

TEMPLATE_ROOT="arte/apps/_template"
TEMPLATE_UI="$TEMPLATE_ROOT/ui"

copy_file() {
  local src="$1"
  local dst="$2"
  mkdir -p "$(dirname "$dst")"
  cp "$src" "$dst"
}

copy_dir() {
  local src="$1"
  local dst="$2"
  mkdir -p "$(dirname "$dst")"
  if [ -d "$dst" ]; then
    mv "$dst" "${dst}.bak-sync"
  fi
  cp -R "$src" "$dst"
  rm -rf "${dst}.bak-sync" 2>/dev/null || true
}

copy_file "vista.art" "$TEMPLATE_UI/vista.art"
copy_dir "src/vista" "$TEMPLATE_UI/src/vista"

mkdir -p "$TEMPLATE_UI/dist/assets/icons"
ICON_NAMES=(
  "log-in"
  "log-out"
  "user-plus"
  "mail"
  "lock"
  "shield-check"
  "shield-off"
  "sliders-horizontal"
)

for icon in "${ICON_NAMES[@]}"; do
  copy_file "dist/assets/icons/${icon}.svg" "$TEMPLATE_UI/dist/assets/icons/${icon}.svg"
done

GRAFITO_SRC=""
if [ -d "${HOME}/.arturo/packages/cache/grafito" ]; then
  GRAFITO_SRC="$(ls -1 "${HOME}/.arturo/packages/cache/grafito"/*/grafito.art 2>/dev/null | sort -V | tail -n 1 || true)"
fi

if [ -n "$GRAFITO_SRC" ] && [ -f "$GRAFITO_SRC" ]; then
  copy_file "$GRAFITO_SRC" "$TEMPLATE_ROOT/vendor/grafito/grafito.art"
else
  echo "warning: grafito cache not found; keeping existing $TEMPLATE_ROOT/vendor/grafito/grafito.art"
fi

echo "Template runtime sync complete."
