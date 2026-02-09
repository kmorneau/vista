---
title: Across & Below
layout: docpage
category: Layout
tags: ["layout", "across", "below", "rows", "columns"]
---

# Across & Below

The across and below keywords are fundamental layout commands that arrange children horizontally (across) or vertically (below).

## Across (Row Layout)
`view .html [
across [
text "First"
text "Second"
text "Third"
]
]`

## Below (Column Layout)
`view .html [
below [
text "First"
text "Second"
text "Third"
]
]`

## Nested Layouts
`view .html [
across [
below [
text "Left Top"
text "Left Bottom"
]
below [
text "Right Top"
text "Right Bottom"
]
]
]`

## See Also

- [Grid System](/wiki/core/layout/grid-system/) - Grid layout

- [Spacing & Padding](/wiki/core/layout/spacing-pad/) - Controlling whitespace
