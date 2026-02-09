---
title: Sprite Sheets
layout: docpage
category: Graphics
tags: []
---

# Sprite Sheets

Reference for Vista Graphics sprite sheet handling and animation.

## Sprite Sheet Basics
`draw canvas [
sprite "characters.png" 0 0 32 32 100 100
]`

## Sprite Parameters

- **Image file**: Sprite sheet image

- **Source X, Y**: Position in sprite sheet

- **Width, Height**: Sprite size

- **Dest X, Y**: Position on canvas

## Animated Sprite
`draw canvas [
sprite "walk.png" (frame * 32) 0 32 32 100 100
]`

## Sprite Animation Tips

- Use consistent sprite sizes

- Organize sprites in grid pattern

- Use sprite sheet for better performance

## See Also

- [Image Drawing](/wiki/graphics/images/image-drawing/) - Basic drawing

- [Animation](/wiki/graphics/animation/) - Animation reference
