---
title: Layout System
layout: docpage
category: Concepts
tags: ["layout", "system", "core"]
---

# Layout System

Vista's layout system provides a declarative way to arrange UI elements using a simple, intuitive syntax.

## Layout Philosophy
Vista uses a flow-based layout system where elements are positioned sequentially. Key layout keywords include:

- `across`: Arrange items in a horizontal row

- `below`: Arrange items in a vertical column

- `return`: Break to next line in current layout

- `end`: Close current layout context

## Across Layout
`
view .html [
across [
button "Yes" []
button "No" []
button "Maybe" []
]
]
`

## Below Layout
`
view .html [
below [
text "First item"
text "Second item"
text "Third item"
]
]
`

## Nested Layouts
Layouts can be nested for complex arrangements:

`
view .html [
panel "Form" [
across [
text "Name:"
field "John Doe"
]
return
across [
text "Email:"
field "john@example.com"
]
]
]
`

## Layout Keywords

- `pad`: Add padding around elements

- `space`: Set gap between elements

- `align`: Align items horizontally

- `valign`: Align items vertically

- `origin`: Set origin position

- `offset`: Offset element position

- `indent`: Add indentation

## Grid Layout
The `grid` face creates a grid layout:

`
view .html [
grid 2 [
text "A1" text "A2"
text "B1" text "B2"
]
]
`

## Row and Column Faces
Use row and col faces for explicit container layouts:

`
view .html [
row [
button "Left"
button "Right"
]
col [
text "Top"
text "Bottom"
]
]
`

## See Also

- [Across and Below](/wiki/core/layout/across-below/) - Basic layout commands

- [Grid System](/wiki/core/layout/grid-system/) - Grid layout

- [Spacing and Padding](/wiki/core/layout/spacing-pad/) - Space and pad keywords

</ul
