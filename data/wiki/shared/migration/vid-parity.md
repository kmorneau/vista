---
title: VID Parity
layout: docpage
category: Migration
tags: ["migration", "vid", "parity", "comparison", "feature-matrix"]
---

# VID Parity

Current parity status between classic VID/REBOL/View patterns and Vista.

## Core Feature Parity

Feature | VID | Vista | Notes
---|---|---|---
Button/Field/Text/Panel | ✅ | ✅ | Supported
Tabs/Slider/Progress | ✅ | ✅ | Supported with extended behavior
Layout words (`across`, `below`, `return`) | ✅ | ✅ | Supported
Scoped layout | ⚠️ | ✅ | Vista adds `scope` and modern container mapping

## Facet/Feel/Actor Parity

Feature | VID | Vista | Notes
---|---|---|---
`facets` dictionaries | ✅ | ✅ | `.facets:#[]` supported
`feel` dictionaries | ✅ | ✅ | Channel + phase mapping supported
`actor` dictionaries | ✅ | ✅ | Normalized into feel/action channels
`apply_facets` runtime updates | ❌ | ✅ | Runtime facet updates for migration flows

## Event/Action Parity

Feature | VID | Vista | Notes
---|---|---|---
`engage` channel | ✅ | ✅ | Preserved, phase-aware
`detect` channel | ✅ | ✅ | Preserved, phase-aware
`redraw` channel | ✅ | ✅ | Preserved, supports `tick`/`show`/`hide`
Normalized event object | ⚠️ | ✅ | Stable payload keys for handlers
Richer pointer/touch action aliases | ❌ | ✅ | `pointer-down`, `touch-start`, `aux-down`, etc.

## Auth/UI Flow Parity Additions

- Intro splash is centered and timed with `.rate:5000` + `.on-tick`.
- Login/signup is gated until splash completes.
- Auth splash behavior is aligned across auth and AI chat examples.

## See Also

- [VID Compatibility](/wiki/shared/migration/vid-compatibility/) - Compatibility guide
- [From Rebol/View](/wiki/shared/migration/from-rebol-view/) - Migration guide
