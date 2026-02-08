# VID Parity Checklist

This checklist compares Vista to classic Rebol/View VID.
Note: `vid_view` has been removed. Use `vista_vid_mode: true` +
`vista_layout_vid_mode: true` with `view` for VID-like behavior.

## Layout
- [x] `across`
- [x] `below`
- [x] `return`
- [x] `end`
- [x] `pad`
- [x] `space`
- [x] `align`
- [x] `valign`
- [x] `size`
- [x] `origin`
- [x] `offset`
- [x] `indent`
- [x] `guide`
- [x] `scope`
- [x] `do`
- [x] Text measurement / auto sizing (font metrics)

## Widgets
- [x] `text`
- [x] `label`
- [x] `title`
- [x] `subtitle`
- [x] `field`
- [x] `info`
- [x] `textarea`
- [x] `checkbox`
- [x] `toggle`
- [x] `radio`
- [x] `slider`
- [x] `rotary`
- [x] `select`
- [x] `drop-list`
- [x] `list`
- [x] `text-list`
- [x] `image`
- [x] `icon` (basic)
- [x] `anim` (basic)
- [x] `progress`
- [x] `box`
- [x] `panel`
- [x] `grid`
- [x] `row`
- [x] `col`
- [x] `group`
- [x] `table*`
- [x] `split`
- [x] `tabs`/`tab`
- [x] `toolbar`
- [x] `menubar`
- [x] `canvas`
- [x] `divider`
- [x] `sensor`
- [ ] `anim` timeline/sprite control
- [ ] `icon`/theme pack support

## Facets
- [x] `color`
- [x] `font` (`family`, `size`, `color`, `weight`, `style`, `bold`, `italic`)
- [x] `para` (`align`, `wrap`, `spacing`, `leading`)
- [x] `edge` (`size`, `color`, `style`, `radius`, `bevel`, `raised`, `inset`)
- [x] `effect` (shadow/emboss/bevel/inset + CSS filter)
- [ ] `feel` deep semantics
- [ ] `rate` deep semantics
- [ ] `options` deep semantics

## Events
- [x] `on-click`
- [x] `on-change`
- [x] `on-input`
- [x] `on-over`
- [x] `on-out`
- [x] `on-down`
- [x] `on-up`
- [x] `on-key`
- [x] `on-focus`
- [x] `on-blur`

## State & Tooling
- [x] Face registry + tree helpers
- [x] Overlay inspector (search/highlight/state)
- [x] UI → Arturo sync
- [x] `ARTURO [...]` header auto‑apply

## Visual Parity
- [x] VID skin (approx)
- [ ] Strict classic VID pixel parity
