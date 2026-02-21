# Release Notes

## Highlights
- Modular architecture: root `vista.art` wrapper + canonical `src/vista/vista.art` split across `src/vista/modules/*.art` and `src/vista/graphics/*.art`.
- VID-style layout words and scoped layout (`scope`).
- VID skin (`vista_vid_mode`) and layout mode (`vista_layout_vid_mode`).
- Extended widget coverage: `info`, `rotary`, `icon`, `anim`, `sensor`, `key`.
- Enhanced list selection and keyboard support.
- Overlay inspector (search, highlight, state).
- App metadata header support via `ARTURO [...]`.
- `view` now always emits the same branded app header used by examples:
  - `ARTURO/VISTA` mark
  - Optional app title (hidden when title is exactly `ARTURO/VISTA`)
  - Logo (`arturo-vista.png` by default, overridable via `ARTURO [Logo: ...]`)
- Expanded Draw dialect coverage in the modular graphics engine (`src/vista/graphics/drawing.art`) including `triangle`, `spline`, `shape`, `arrow`, `clip`, `fill-rule`, `grad-pen`, matrix operations, and transform helpers.
- REBOL-style facet/feel/actor parity expansion and auth splash/login flow hardening across runtime, docs, and tests.

## REBOL Styling + Vista Fixes
- Added REBOL-compat runtime mode and richer facet/actor mapping pipeline for migration-oriented code paths.
- Added/expanded mappings for `.facets:#[]`, `.actor:#[]`, `.feel:#[]` into runtime `data-*` attributes and JS handlers.
- Added explicit channel support for `engage`, `detect`, and `redraw` with phase-pair/phase-map handling.
- Expanded action vocabulary and normalized event object payloads to better match REBOL/View-style handler expectations.
- Added helper coverage in view entry layer (`apply_facets`, actor/facet application helpers) for runtime updates and migration parity.
- Improved list selection affordances and state visibility in examples using the updated parity/event pipeline.
- Hardened auth flow:
  - Intro splash dialog is centered and auto-transitions after 5 seconds using `.rate` + `.on-tick`.
  - Login/signup panels remain blocked until splash completes.
  - Splash presentation is aligned between auth demo and AI chat example behavior.
- Updated docs to reflect current helper signatures and managed auth state flow (`auth_app`), including required state keys and startup state.
- Added test coverage for rate/feel parity and normalized event payload contracts (`tests/64-rate-feel-tests.art`).

## New/Updated Flags
- `vista_vid_mode` (classic skin)
- `vista_layout_vid_mode` (VID layout containers)
- `vista_rebol_compat_mode` (extended REBOL-style facet/feel/actor compatibility behavior)
- `webview_state_sync_from_ui` (UI -> Arturo sync)
- `webview_state_push_ms` (sync throttle)

## New Helpers
- `view` (VID skin + layout)
- `face_tree_pretty`, `face_tree_overlay`, `face_tree_by_id_json`

## Compatibility Notes
- `list` now supports multi-select and keyboard nav.
- `edge` accepts `bevel`, `raised`, `inset`.
- `tabs` supports `.selected` for initial tab.
- `feel`, `rate`, and `options` facets are mapped in modular runtime (`data-*` attrs + helper scripts/APIs).

## Removals
- `vid_view` (use `vista_vid_mode` + `vista_layout_vid_mode` with `view`).
