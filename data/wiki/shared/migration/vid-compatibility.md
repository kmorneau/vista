---
title: VID Compatibility
layout: docpage
category: Migration
tags: ["migration", "vid", "compatibility", "legacy"]
---

# VID Compatibility

Vista supports VID-style syntax while extending behavior for REBOL/View migration.

## Supported VID Features

- Face definitions and standard widgets
- Layout keywords: `across`, `below`, `return`, `pad`, `space`
- Attribute-based styling and events
- Action blocks compiled to runtime handlers

## Compatibility Notes

- `feel`, `actor`, and `facets` are supported through compatibility mappings.
- Legacy dictionaries are normalized to Vista runtime `data-*` channels.
- `engage`, `detect`, and `redraw` channels are preserved and executable.
- Event objects are normalized so handlers receive stable, View-like payload keys.

## Legacy to Vista Mapping

Feature | Current Status | Vista Behavior
---|---|---
`vid:` wrapper | Optional | Use `view [...]` directly
`feel: object` | Supported | Mapped to feel channels and phase handlers
`facets: [...]` | Supported | Mapped to face attributes/runtime facets
`actor: [...]` | Supported | Normalized into feel/action channels

## Compatibility Mode
`
; Enable VID-style migration behavior
vista_vid_mode: true
vista_layout_vid_mode: true
vista_rebol_compat_mode: true
`

## Migration Checklist

- Keep legacy `feel`/`actor`/`facets` where useful, or progressively move to direct attributes.
- Validate phase-specific handlers (`down`, `up`, `move`, `tick`) for expected behavior.
- Confirm event payload usage (`value\action`, pointer/keyboard keys, modifiers).
- Test auth splash/login flows if migrating older auth examples.

## See Also

- [VID Parity](/wiki/shared/migration/vid-parity/) - Full feature comparison
- [From Rebol/View](/wiki/shared/migration/from-rebol-view/) - Migration guide
