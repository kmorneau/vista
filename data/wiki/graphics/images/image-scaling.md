---
title: Image Scaling
layout: docpage
category: Graphics
tags: ["graphics", "images", "scaling", "resize", "reference"]
---

# Image Scaling

Reference for Vista Graphics image scaling commands.

## Scale to Size
`draw canvas [
image "photo.jpg" 100 100 200 150
]`

## Maintain Aspect Ratio
`draw canvas [
image "photo.jpg" 100 100 200
]`

## Stretch to Fill
`draw canvas [
image "photo.jpg" 0 0 400x300
]`

## Scaling Modes

- **fit**: Scale to fit within bounds (maintains aspect ratio)

- **fill**: Scale to fill bounds (may crop)

- **stretch**: Stretch to fill bounds (distorts)

- **none**: No scaling (use original size)

## Performance Tips

- Use appropriately sized images (don't scale up small images)

- Consider image formats (PNG for graphics, JPEG for photos)

- Preload images when possible

## See Also

- [Image Drawing](/wiki/graphics/images/image-drawing/) - Basic drawing

- [Sprite Sheets](/wiki/graphics/images/sprite-sheets/) - Sprite animation
