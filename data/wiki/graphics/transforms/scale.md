---
title: Scale
layout: docpage
category: Transforms
tags: ["graphics", "transforms", "scale", "resize"]
---

# Scale

Scale subsequent drawing operations.

## Basic Scaling
`draw canvas [
scale 2 2
box 0 0 50 50
]`

## Parameters

- **x-scale**: Horizontal scale factor

- **y-scale**: Vertical scale factor

## Uniform Scaling
`draw canvas [
scale 1.5
circle 100 100 50
]`

## Negative Scale (Flip)
`draw canvas [
scale -1 1
text "Flipped" 100 100
]`

## See Also

- [Transforms](/wiki/graphics/transforms/) - Transform overview

- [Rotate](/wiki/graphics/transforms/rotate/) - Rotation transforms
