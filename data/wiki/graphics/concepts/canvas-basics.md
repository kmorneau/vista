---
title: Canvas Basics
layout: docpage
category: Concepts
tags: ["graphics", "concepts", "canvas", "setup", "basics"]
---

# Canvas Basics

Learn the basics of setting up and using canvas elements for custom graphics.

## Creating a Canvas
`view .html [
canvas 800x600
]`

## Canvas with Drawing
`view .html [
canvas 800x600 [
draw [
pen red
fill blue
circle 400 300 100
]
]
]`

## Canvas Attributes

- **width**: Canvas width in pixels

- **height**: Canvas height in pixels

- **draw**: Initial drawing commands

## Dynamic Canvas
`view .html [
canvas 800x600 [
on-draw: function [] [
drawScene
]
]
]`

## Best Practices

- Use appropriate canvas size for your content

- Consider using on-draw for dynamic content

- Optimize drawing operations for performance

## See Also

- [Graphics Overview](/wiki/graphics/concepts/graphics-overview/) - Introduction

- [Drawing](/wiki/graphics/drawing/) - Drawing reference
