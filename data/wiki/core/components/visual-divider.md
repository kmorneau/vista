---
title: Visual Dividers
layout: docpage
category: Components
tags: ["components", "divider", "spacer", "split", "visual"]
---

# Visual Dividers

Visual dividers are components that help organize content and create visual separation.

## Divider
`view .html [
text "Section 1"
divider
text "Section 2"
]`

## Spacer
`view .html [
text "Top"
spacer 50
text "Bottom"
]`

## Split
`view .html [
split [
text "Left Panel"
] [
text "Right Panel"
]
]`

## Divider Attributes

- **divider**: Horizontal or vertical line

- **spacer**: Fixed-size space

- **split**: Resizable panel splitter

## See Also

- [Containers](/wiki/core/components/containers/) - Container components

- [Spacing & Padding](/wiki/core/layout/spacing-pad/) - Spacing control
