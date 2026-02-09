---
title: Alignment
layout: docpage
category: Layout
tags: ["layout", "alignment", "valign", "center", "position"]
---

# Alignment

Control the alignment of content within containers using align and valign attributes.

## Horizontal Alignment
`view .html [
row [
align: 'left
text "Left"
]
row [
align: 'center
text "Center"
]
row [
align: 'right
text "Right"
]
]`

## Vertical Alignment
`view .html [
row [
valign: 'top
text "Top"
]
row [
valign: 'middle
text "Middle"
]
row [
valign: 'bottom
text "Bottom"
]
]`

## Alignment Values

- **Horizontal**: left, center, right, justify

- **Vertical**: top, middle, bottom

## See Also

- [Spacing & Padding](/wiki/core/layout/spacing-pad/) - Spacing control

- [Origin & Offset](/wiki/core/layout/origin-offset/) - Positioning control
