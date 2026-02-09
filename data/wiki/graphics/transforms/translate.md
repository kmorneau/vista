---
title: Translate
layout: docpage
category: Transforms
tags: ["graphics", "transforms", "translate", "position"]
---

# Translate

Move the origin point for subsequent drawing operations.

## Basic Translation
`draw canvas [
translate 100 50
box 0 0 100 100
]`

## Parameters

- **x**: Horizontal offset

- **y**: Vertical offset

## Relative Translation
`draw canvas [
translate 50 50
box 0 0 50 50
translate 50 50
box 0 0 50 50
]`

## See Also

- [Transforms](/wiki/graphics/transforms/) - Transform overview

- [Rotate](/wiki/graphics/transforms/rotate/) - Rotation transforms
