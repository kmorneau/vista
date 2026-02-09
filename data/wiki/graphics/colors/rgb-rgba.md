---
title: RGB & RGBA
layout: docpage
category: Colors
tags: []
---

# RGB & RGBA Colors

Vista Graphics supports RGB and RGBA color specifications.

## RGB Syntax
`draw canvas [
fill rgb 255 0 0    ; Red
fill rgb 0 255 0    ; Green
fill rgb 0 0 255    ; Blue
]`

## RGBA Syntax
`draw canvas [
fill rgba 255 0 0 0.5    ; Semi-transparent red
fill rgba 0 255 0 0.3    ; More transparent green
]`

## Parameters

- **Red**: 0-255

- **Green**: 0-255

- **Blue**: 0-255

- **Alpha**: 0.0-1.0 (RGBA only)

## Hex Shortcuts
`draw canvas [
fill #FF0000    ; Red
fill #00FF00    ; Green
fill #0000FF    ; Blue
]`

## See Also

- [Color Overview](/wiki/graphics/colors/color-overview/) - Color introduction

- [Named Colors](/wiki/graphics/colors/named-colors/) - Named color reference
