---
title: Pen & Fill
layout: docpage
category: Graphics
tags: ["graphics", "drawing", "pen", "fill", "styles", "reference"]
---

# Pen & Fill

Reference for Vista Graphics pen and fill styles.

## Pen Styles

- **pen**: Set outline color/style

- **pen-width**: Set outline width

- **pen-cap**: Set line cap style

- **pen-join**: Set line join style

## Fill Styles

- **fill**: Set fill color/style

- **no-fill**: Disable fill

## Example
`draw canvas [
pen red
pen-width 3
fill blue
box 10 10 100 100
]`

## Line Caps

- **butt**: Flat end

- **round**: Round end

- **square**: Square end

## Line Joins

- **miter**: Sharp corner

- **round**: Round corner

- **bevel**: Beveled corner

## See Also

- [Colors](/wiki/graphics/colors/) - Color reference

- [Primitives](/wiki/graphics/drawing/primitives/) - Drawing primitives
