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

## New/Updated Flags
- `vista_vid_mode` (classic skin)
- `vista_layout_vid_mode` (VID layout containers)
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
