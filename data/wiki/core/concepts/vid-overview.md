---
title: VID Overview
layout: docpage
category: Concepts
tags: ["vid", "ui", "dialect", "core"]
---

# VID Overview

VID (Visual Interface Dialect) is the declarative UI syntax used by Vista. It maps concise blocks to a face tree and runtime behavior.

## Core Concepts

- **Faces**: UI nodes with facets, handlers, and state.
- **Layout flow**: `across`, `below`, `return`, scoped containers.
- **Action blocks**: Compiled handlers for UI interaction.
- **Compatibility layers**: REBOL/View-style `facets`, `feel`, and `actor` mappings.

## Syntax
`
view [
text "Label"
button "Click Me" [print "clicked"]
]
`

## REBOL/View Compatibility Notes

- `.facets:#[]` and `.actor:#[]` are supported.
- `feel` channels (`engage`, `detect`, `redraw`) are supported, including phase maps.
- Event payloads are normalized for handler stability.
- Use `vista_rebol_compat_mode: true` for migration-heavy code.

## References

- [VID Compatibility](/wiki/shared/migration/vid-compatibility/)
- [VID Parity](/wiki/shared/migration/vid-parity/)
- [From Rebol/View](/wiki/shared/migration/from-rebol-view/)

## See Also

- [Getting Started](/wiki/getting-started/) - Quick start with Vista
- [Face Model](/wiki/core/concepts/face-model/) - Face/facet architecture
- [Layout System](/wiki/core/concepts/layout-overview/) - Layout patterns
