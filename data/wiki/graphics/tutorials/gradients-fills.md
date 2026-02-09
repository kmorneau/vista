---
title: Gradients & Fills
layout: docpage
category: Tutorials
tags: ["graphics", "tutorials", "gradients", "fills", "colors"]
---

# Gradients & Fills

Learn how to create and apply gradients and fill styles to your graphics.

## Linear Gradients
`draw canvas [
fill linear 0 0 200 0 red orange yellow
box 0 0 200 100
]`

## Radial Gradients
`draw canvas [
fill radial 100 100 100 white blue
circle 100 100 100
]`

## Solid Fills
`draw canvas [
fill red
circle 100 100 50
]`

## Gradient Parameters

- **Linear**: x1 y1 x2 y2 color1 color2 ...

- **Radial**: x y r color1 color2 ...

## See Also

- [Colors](/wiki/graphics/colors/) - Color reference

- [Primitives](/wiki/graphics/drawing/primitives/) - Drawing primitives
