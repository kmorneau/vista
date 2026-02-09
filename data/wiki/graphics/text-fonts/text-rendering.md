---
title: Text Rendering
layout: docpage
category: Graphics
tags: ["graphics", "text", "rendering", "fonts", "reference"]
---

# Text Rendering

Reference for Vista Graphics text rendering commands.

## Basic Text
`draw canvas [
text "Hello, World!" 100 100
]`

## Text with Font
`draw canvas [
font "Arial" 16
text "Hello, World!" 100 100
]`

## Text Commands

- **text**: Draw text at position

- **font**: Set font family and size

- **font-color**: Set text color

- **font-style**: Set font style (bold, italic)

## Styled Text
`draw canvas [
font "Arial" 24
font-color red
text "Styled Text" 100 100
]`

## See Also

- [Font Settings](/wiki/graphics/text-fonts/font-settings/) - Font reference

- [Text Alignment](/wiki/graphics/text-fonts/text-alignment/) - Alignment options
