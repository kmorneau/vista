---
title: Text & Images
layout: docpage
category: Tutorials
tags: ["graphics", "tutorials", "text", "images", "rendering"]
---

# Text & Images

Learn how to render text and images on canvas.

## Basic Text
`draw canvas [
font "Arial" 16
text "Hello, World!" 100 100
]`

## Image Drawing
`draw canvas [
image "logo.png" 100 100
image "sprite.png" 200 100 64 64
]`

## Text with Styling
`draw canvas [
font "Arial" 24
text-align 'center
text "Centered Text" 200 100
]`

## Image Scaling
`draw canvas [
image "photo.jpg" 100 100 300 200
]`

## See Also

- [Text & Fonts](/wiki/graphics/text-fonts/) - Text reference

- [Images](/wiki/graphics/images/) - Image reference
