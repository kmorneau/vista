---
title: Text Alignment
layout: docpage
category: Graphics
tags: ["graphics", "text", "alignment", "reference"]
---

# Text Alignment

Reference for Vista Graphics text alignment commands.

## Horizontal Alignment
`draw canvas [
text-align 'left
text "Left" 100 50

text-align 'center
text "Center" 100 100

text-align 'right
text "Right" 100 150
]`

## Vertical Alignment
`draw canvas [
text-baseline 'top
text "Top" 100 100

text-baseline 'middle
text "Middle" 200 100

text-baseline 'bottom
text "Bottom" 300 100
]`

## Alignment Values

- **Horizontal**: left, center, right

- **Vertical**: top, middle, bottom, alphabetic

## Combined Alignment
`draw canvas [
text-align 'center
text-baseline 'middle
text "Centered" 200 100
]`

## See Also

- [Text Rendering](/wiki/graphics/text-fonts/text-rendering/) - Text rendering

- [Font Settings](/wiki/graphics/text-fonts/font-settings/) - Font reference
