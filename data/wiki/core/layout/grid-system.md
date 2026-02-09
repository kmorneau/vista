---
title: Grid System
layout: docpage
category: Layout
tags: ["layout", "grid", "rows", "columns", "table"]
---

# Grid System

The grid system provides powerful table-like layout capabilities for organizing content in rows and columns.

## Basic Grid
`view .html [
grid [
text "A1" "B1" "C1"
text "A2" "B2" "C2"
text "A3" "B3" "C3"
]
]`

## Grid with Spanning
`view .html [
grid [
title "Header" "Header" "Header"
text "Cell" "Cell" "Cell"
text "Cell" [span 2] "Cell"
]
]`

## Grid Options

- **span**: Span multiple cells

- **header**: Mark row as header

- **footer**: Mark row as footer

## See Also

- [Across & Below](/wiki/core/layout/across-below/) - Basic layout

- [Data Display](/wiki/core/components/data-display/) - Table components
