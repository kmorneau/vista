---
title: Pixel Art Mode
layout: docpage
category: Graphics
tags: ["graphics", "pixel-art", "retro", "games"]
---

# Pixel Art Mode

Vista Graphics supports pixel art rendering mode for crisp, retro-style graphics.

## Enable Pixel Art Mode
`draw canvas [
pixel-art on
image "sprite.png" 100 100
]`

## Pixel Art Settings

- **pixel-art on**: Enable nearest-neighbor interpolation

- **pixel-art off**: Disable (use smooth scaling)

- **pixel-ratio**: Set pixel ratio for canvas

## Best Practices

- Use when scaling pixel art sprites

- Set canvas size to match pixel art dimensions

- Disable anti-aliasing for crisp edges

## Example: Pixel Art Game Sprite
`draw canvas [
pixel-art on
image "character.png" 16 16 64 64
]`

## See Also

- [Image Scaling](/wiki/graphics/images/image-scaling/) - Scaling images

- [Sprite Sheets](/wiki/graphics/images/sprite-sheets/) - Sprite animation
