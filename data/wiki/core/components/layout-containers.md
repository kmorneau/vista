---
title: Layout Containers
layout: docpage
category: Components
tags: ["components", "layout", "containers", "row", "col", "grid"]
---

# Layout Containers

Layout containers are specialized components designed to organize and arrange child elements.

## Row
`view .html [
row [
text "Item 1"
text "Item 2"
text "Item 3"
]
]`

## Column
`view .html [
col [
text "Item 1"
text "Item 2"
text "Item 3"
]
]`

## Grid
`view .html [
grid [
text "A1" "B1" "C1"
text "A2" "B2" "C2"
]
]`

## Container Attributes

- **spacing**: Space between children

- **align**: Horizontal alignment

- **valign**: Vertical alignment

## See Also

- [Layout](/wiki/core/layout/) - Layout system

- [Containers](/wiki/core/components/containers/) - General containers
