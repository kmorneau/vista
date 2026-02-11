---
title: Drawing Primitives Tutorial
layout: tutorial
category: Graphics
tags: ["tutorial", "graphics", "drawing", "beginner"]
---

# Drawing Primitives Tutorial

Learn how to draw basic shapes using Vista Graphics.

## Setup
`
import 'vista-graphics!
`

## Drawing Lines
Use the `line` command to draw lines:

`
canvas [
draw [
pen red
line 10 10 200 100
]
]
`

## Drawing Rectangles
Use the `box` command to draw rectangles:

`
canvas [
draw [
pen blue
fill-pen lightblue
box 10 10 100 100
]
]
`

## Drawing Circles
Use the `circle` command to draw circles:

`
canvas [
draw [
pen green
fill-pen lightgreen
circle 150 150 50
]
]
`

## Drawing Ellipses
Use the `ellipse` command to draw ellipses:

`
canvas [
draw [
pen purple
fill-pen lavender
ellipse 150 150 100 50
]
]
`

## Drawing Polygons
Use the `polygon` command to draw polygons:

`
canvas [
draw [
pen orange
fill-pen yellow
polygon [
150 50
200 150
100 150
]
]
]
`

## Styling
Control line width and style:

`
canvas [
draw [
line-width 3
line-cap round
line-join round
pen red
line 10 10 200 100
]
]
`

## Complete Example
`
view .html [
canvas [
draw [
pen black
fill-pen wheat

; House
box 100 150 200 150

; Roof
polygon [
90 150
200 50
310 150
]

; Door
pen brown
fill-pen saddlebrown
box 175 220 50 80
]
]
]
`

## Next Steps

- [Gradients and Fills](/wiki/graphics/tutorials/gradients-fills/) - Color and gradients

- [Text Rendering](/wiki/graphics/text-fonts/text-rendering/) - Drawing text

- [Transformations](/wiki/graphics/transforms/) - Rotate, scale, translate

</ul
