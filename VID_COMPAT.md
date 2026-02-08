# Vista VID Compatibility

This document tracks Rebol/View VID-style compatibility and recommended flags.

## Quick Start

- `vista_vid_mode: true` enables classic skin globally.
- `vista_layout_vid_mode: true` enables VID-like `across`/`below`/`return` containers.
- For a single VID-like view, set both and call `view`:

```arturo
vista_vid_mode: true
vista_layout_vid_mode: true
view [
    text "Hello"
]
```

Note: `vid_view` has been removed. Use the flags above with `view`.

## Supported (High-Level)

- Layout words: `across`, `below`, `return`, `end`, `pad`, `space`, `align`, `valign`, `size`, `origin`, `offset`, `indent`, `guide`, `do`, `scope`
- Faces: `text`, `label`, `title`, `subtitle`, `field`, `info`, `button`, `key`, `checkbox`, `toggle`, `radio`, `slider`, `rotary`, `textarea`, `select`, `drop-list`, `image`, `icon`, `anim`, `progress`, `box`, `panel`, `grid`, `row`, `col`, `group`, `table*`, `toolbar`, `menubar`, `split`, `canvas`, `divider`, `sensor`, `tabs`/`tab`
- Draw dialect (HTML5 Canvas) via [`vista-graphics.art`](vista-graphics.art:1) and `canvas [draw-block]`
- Face registry + debug helpers + overlay inspector
- State bindings, live updates, and optional UI->Arturo sync

## Facets (MVP)

- `color`, `font` (`family`, `size`, `color`, `weight`, `style`, `bold`, `italic`)
- `para` (`align`, `wrap`, `spacing`, `leading`)
- `edge` (`size`, `color`, `style`, `radius`, plus `bevel`/`raised`/`inset`)
- `effect` (`shadow`, `inset`, `raised`, `emboss`, `bevel`, or CSS filter)

## Events

- `on-click`, `on-change`, `on-input`
- `on-over`, `on-out`, `on-down`, `on-up`
- `on-key`, `on-focus`, `on-blur`

## Known Gaps (Phase 9 candidates)

- Deeper VID feel for `feel`/`rate`/`options`.
- More accurate size/spacing metrics vs. classic VID.
- Text metrics for auto-sizing based on font/para.
