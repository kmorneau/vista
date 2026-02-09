---
title: Image Drawing
layout: docpage
category: Graphics
tags: ["graphics", "images", "drawing", "reference"]
---

# Image Drawing

Reference for Vista Graphics image drawing commands.

## Basic Image Drawing
`draw canvas [
image "photo.jpg" 100 100
]`

## Image with Size
`draw canvas [
image "photo.jpg" 100 100 200 150
]`

## Image Commands

- **image**: Draw image at position

- **image-size**: Get image dimensions

- **crop**: Draw portion of image

## Cropped Image
`draw canvas [
crop "photo.jpg" 0 0 100 100 200 200
]`

## Supported Formats

- PNG (recommended for graphics)

- JPEG (for photographs)

- GIF (animated images supported)

- SVG (vector images)

## See Also

- [Image Scaling](/wiki/graphics/images/image-scaling/) - Scaling images

- [Sprite Sheets](/wiki/graphics/images/sprite-sheets/) - Sprite animation
