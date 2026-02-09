---
title: Polygons
layout: docpage
category: Graphics
tags: ["graphics", "drawing", "polygons", "shapes", "reference"]
---

# Polygons

Reference for Vista Graphics polygon drawing commands.

## Basic Polygon
`draw canvas [
polygon 100 100 150 50 200 100 150 150
]`

## Regular Polygon
`draw canvas [
triangle 100 100 50
square 200 100 50
pentagon 100 200 50
hexagon 200 200 50
]`

## Polygon Parameters

- **polygon**: x1 y1 x2 y2 ... (vertex list)

- **triangle**: center-x center-y radius

- **square**: center-x center-y size

- **pentagon**: center-x center-y radius

- **hexagon**: center-x center-y radius

## Filled Polygon
`draw canvas [
fill red
polygon 100 100 150 50 200 100 150 150
]`

## See Also

- [Primitives](/wiki/graphics/drawing/primitives/) - Basic shapes

- [Paths](/wiki/graphics/drawing/paths/) - Path operations
