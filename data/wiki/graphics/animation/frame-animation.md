---
title: Frame Animation
layout: docpage
category: Animation
tags: ["graphics", "animation", "frames", "reference"]
---

# Frame Animation

Vista Graphics supports frame-based animation for sprites and sequences.

## Frame Counter
`draw canvas [
frame: frame + 1
sprite "animation.png" (frame % 4 * 32) 0 32 32 100 100
]`

## Animation Speed
`draw canvas [
frame: frame + 1
sprite "walk.png" ((frame / 5) % 4 * 32) 0 32 32 100 100
]`

## Frame Control

- **frame**: Current frame counter

- **fps**: Frames per second

- **frame-time**: Time since last frame

## See Also

- [Animation Basics](/wiki/graphics/animation/animation-basics/) - Fundamentals

- [Sprite Sheets](/wiki/graphics/images/sprite-sheets/) - Sprite animation
