---
title: Rotate
layout: docpage
category: Transforms
tags: []
---

# Rotate

Rotate subsequent drawing operations around the origin.

## Basic Rotation
`draw canvas [
rotate 45
box 0 0 100 100
]`

## Parameters

- **angle**: Rotation angle in degrees

## Rotate Around Point
`draw canvas [
translate 100 100
rotate 45
translate -50 -50
box 0 0 100 100
]`

## See Also

- [Transforms](/wiki/graphics/transforms/) - Transform overview

- [Scale](/wiki/graphics/transforms/scale/) - Scale transforms
