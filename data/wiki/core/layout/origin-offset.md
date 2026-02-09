---
title: Origin & Offset
layout: docpage
category: Layout
tags: ["layout", "origin", "offset", "position", "coordinates"]
---

# Origin & Offset

Control the precise positioning of components using origin and offset attributes.

## Origin
`view .html [
box red 100x100 [
origin: 10x10
]
]`

## Offset
`view .html [
box blue 100x100 [
offset: 50x50
]
]`

## Combined Usage
`view .html [
panel [
origin: 20x20
offset: 10x10
text "Positioned content"
]
]`

## Use Cases

- Precise component positioning

- Creating custom layouts

- Implementing drag-and-drop

- Building overlay systems

## See Also

- [Alignment](/wiki/core/layout/alignment-valign/) - Alignment options

- [Scope & Nesting](/wiki/core/layout/scope-nesting/) - Scoped layouts
