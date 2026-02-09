---
title: Spacing & Padding
layout: docpage
category: Layout
tags: ["layout", "spacing", "padding", "margin", "style"]
---

# Spacing & Padding

Control the whitespace around and within components using spacing and padding attributes.

## Padding
`view .html [
box blue 200x200 [
padding: 20
text "Content with padding"
]
]`

## Spacing Between Children
`view .html [
across [
spacing: 10
text "Item 1"
text "Item 2"
text "Item 3"
]
]`

## Margin
`view .html [
button "Click Me" [
margin: 10
]
]`

## Attributes

- **padding**: Space inside the component

- **spacing**: Space between children

- **margin**: Space outside the component

## See Also

- [Alignment](/wiki/core/layout/alignment-valign/) - Alignment options

- [CSS Classes](/wiki/shared/styles/css-classes/) - Styling reference
