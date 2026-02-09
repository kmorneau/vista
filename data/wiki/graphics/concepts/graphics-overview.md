---
title: Vista Graphics Overview
layout: docpage
category: Graphics
tags: ["graphics", "canvas", "drawing", "overview"]
---

# Vista Graphics Overview

Vista Graphics provides a declarative way to draw 2D graphics on HTML5 Canvas, inspired by the Rebol/View Draw dialect.

## Key Concepts

- **Draw Block**: A block of drawing commands

- **Pen**: The outline color/styling

- **Fill Pen**: The fill color/styling

- **Canvas**: The HTML5 canvas element

## Basic Drawing
`
view .html [
canvas #myCanvas [
draw [
pen red
fill-pen blue
box 10 10 100 100
]
]
]
`

## Drawing Commands

- `line` - Draw a line between two points

- `box` - Draw a rectangle

- `circle` - Draw a circle

- `ellipse` - Draw an ellipse

- `polygon` - Draw a polygon

- `text` - Draw text

- `image` - Draw an image

## Color and Styling
`
view .html [
canvas [
draw [
; Named colors
pen red
fill-pen green

; RGB colors
fill-pen 255 128 0

; RGBA colors
fill-pen 255 0 0 0.5

; Gradients
fill-pen linear-gradient 0 0 100 100
0.0 yellow
1.0 red

box 10 10 100 100
]
]
]
`

## Transformations
`
view .html [
canvas [
draw [
translate 50 50
rotate 45
scale 2 2
pen blue
box 0 0 100 100
]
]
]
`

## Coordinate Systems
Vista Graphics supports multiple coordinate systems:

- **VID (default)**: Top-left origin, Y down

- **Math**: Bottom-left origin, Y up

- **Center**: Origin at canvas center

## See Also

- [Drawing Primitives](/wiki/graphics/drawing/primitives/) - Lines and shapes

- [Transformations](/wiki/graphics/transforms/transform-overview/) - Rotate, scale, translate

- [Colors](/wiki/graphics/colors/color-overview/) - Color and gradient reference

</ul
