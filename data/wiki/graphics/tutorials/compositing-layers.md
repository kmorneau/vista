---
title: Compositing & Layers
layout: docpage
category: Tutorials
tags: ["graphics", "tutorials", "compositing", "layers", "push", "pop"]
---

# Compositing & Layers

Learn how to manage drawing state and create layered graphics with push/pop.

## Push/Pop State
`draw canvas [
pen red
box 0 0 100 100

push [
pen blue
rotate 45
box 50 50 100 100
]

pen green
circle 150 150 50
]`

## Saved State
The push command saves:

- Current pen color/style

- Current fill color/style

- Current transformation matrix

- Current font settings

## Layering Tips

- Use push/pop to isolate transformation effects

- Draw background elements first

- Use transparency for overlapping effects

## See Also

- [Draw Model](/wiki/graphics/concepts/draw-model/) - Drawing concepts

- [Drawing](/wiki/graphics/drawing/) - Drawing reference
