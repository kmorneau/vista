---
title: Canvas
layout: docpage
category: Components
tags: ["components", "canvas", "drawing", "graphics"]
---

# Canvas Component

The canvas component provides a drawing area for custom graphics and visualizations.

## Basic Canvas
`view .html [
canvas 400x300
]`

## Canvas with Drawing
`view .html [
canvas 400x300 [
draw [
pen red
fill blue
circle 200 150 100
]
]
]`

## Canvas Attributes

- **width/height**: Canvas dimensions

- **draw**: Drawing commands block

- **on-draw**: Dynamic drawing callback

## Dynamic Canvas
`view .html [
canvas 400x300 [
on-draw [
drawScene
]
]
]`

## See Also

- [Vista Graphics](/wiki/graphics/) - Graphics library

- [Drawing Primitives](/wiki/graphics/tutorials/drawing-primitives/) - Drawing basics
