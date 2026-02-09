---
title: Draw Model
layout: docpage
category: Concepts
tags: ["graphics", "concepts", "draw", "model", "dialect"]
---

# Draw Model

The Draw Model is Vista Graphics' declarative drawing dialect for creating 2D graphics on canvas elements.

## Draw Block Structure
`draw canvas [
pen red
fill blue
circle 100 100 50
]`

## Drawing State
The draw model maintains state for:

- **pen**: Current outline color/style

- **fill**: Current fill color/style

- **font**: Current text font

- **transform**: Current transformation matrix

## Push/Pop State
`draw canvas [
pen red
box 0 0 100 100
push [
pen blue
rotate 45
box 0 0 100 100
]
box 100 100 100 100
]`

## See Also

- [Drawing](/wiki/graphics/drawing/) - Drawing reference

- [Coordinate Systems](/wiki/graphics/concepts/coordinate-systems/) - Coordinates
