# Release Notes

## Highlights
- VID-style layout words and scoped layout (`scope`).
- VID skin (`vista_vid_mode`) and layout mode (`vista_layout_vid_mode`).
- Extended widget coverage: `info`, `rotary`, `icon`, `anim`, `sensor`, `key`.
- Enhanced list selection and keyboard support.
- Overlay inspector (search, highlight, state).
- App metadata header support via `ARTURO [...]`.

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

## Removals
- `vid_view` (use `vista_vid_mode` + `vista_layout_vid_mode` with `view`).
