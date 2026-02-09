---
title: Coordinate Systems
layout: docpage
category: Graphics
tags: ["coordinates", "transforms", "graphics"]
---

# Coordinate Systems

Vista Graphics supports multiple coordinate systems for different drawing needs.

## VID Coordinates (Default)
The default coordinate system with origin at the top-left corner:

- X increases to the right

- Y increases downward

- (0, 0) is at the top-left

## Math Coordinates
A mathematical coordinate system with origin at the bottom-left:

`
canvas [
draw [
coord-system math
pen red
line 0 0 100 100
]
]
`

## Center Coordinates
A coordinate system with origin at the canvas center:

`
canvas [
draw [
coord-system center
pen blue
line -50 0 50 0
line 0 -50 0 50
]
]
`

## Coordinate Format
Coordinates can be specified as:

- **Block**: `[x y]` or `[10 20]`

- **String**: `"10 20"`

- **Two numbers**: `10 20`

## Point Specification
`
canvas [
draw [
; All equivalent
line [10 20] [100 200]
line "10 20" "100 200"
line 10 20 100 200
]
]
`

## See Also

- [Translate](/wiki/graphics/transforms/translate/) - Move origin

- [Rotate](/wiki/graphics/transforms/rotate/) - Rotate coordinate system

- [Scale](/wiki/graphics/transforms/scale/) - Scale coordinates

</ul
