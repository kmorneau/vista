---
title: Paths
layout: docpage
category: Graphics
tags: ["graphics", "drawing", "paths", "reference"]
---

# Paths

Reference for Vista Graphics path operations.

## Path Commands

- **move**: Move to position without drawing

- **line**: Draw line to position

- **curve**: Draw quadratic curve

- **arc**: Draw arc

- **close**: Close path

## Basic Path
`draw canvas [
path [
move 100 100
line 200 100
line 150 200
close
]
]`

## Curved Path
`draw canvas [
path [
move 100 200
curve 100 100 200 100 200 200
]
]`

## Path with Stroke
`draw canvas [
pen red
path [
move 100 100
line 200 100
line 150 200
close
]
]`

## See Also

- [Polygons](/wiki/graphics/drawing/polygons/) - Polygon drawing

- [Pen & Fill](/wiki/graphics/drawing/pen-fill/) - Styling
