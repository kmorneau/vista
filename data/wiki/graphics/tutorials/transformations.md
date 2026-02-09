---
title: Transformations
layout: docpage
category: Tutorials
tags: ["graphics", "tutorials", "transforms", "rotate", "scale", "translate"]
---

# Transformations

Learn how to apply geometric transformations to your graphics.

## Translation
`draw canvas [
translate 50 50
box 0 0 100 100
]`

## Rotation
`draw canvas [
rotate 45
box 0 0 100 100
]`

## Scaling
`draw canvas [
scale 2 2
box 0 0 50 50
]`

## Combined Transforms
`draw canvas [
translate 100 100
rotate 30
scale 1.5 1.5
circle 0 0 50
]`

## Transform Order
Transformations are applied in reverse order of declaration.

## See Also

- [Transforms](/wiki/graphics/transforms/) - Transform reference

- [Coordinate Systems](/wiki/graphics/concepts/coordinate-systems/) - Coordinates
