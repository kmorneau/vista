---
title: Gradient Fills
layout: docpage
category: Colors
tags: ["graphics", "colors", "gradients", "fills", "reference"]
---

# Gradient Fills

Vista Graphics supports linear and radial gradient fills.

## Linear Gradient
`draw canvas [
fill linear 0 0 200 0 red orange yellow green
box 0 0 200 100
]`

## Radial Gradient
`draw canvas [
fill radial 100 100 80 white blue purple
circle 100 100 80
]`

## Parameters

- **Linear**: x1 y1 x2 y2 color1 color2 ...

- **Radial**: x y r color1 color2 ...

## Multiple Color Stops
`draw canvas [
fill linear 0 0 200 0 red orange yellow green blue purple
box 0 0 200 100
]`

## See Also

- [Color Overview](/wiki/graphics/colors/color-overview/) - Color introduction

- [Gradients Tutorial](/wiki/graphics/tutorials/gradients-fills/) - Learning guide
