---
title: Face Model
layout: docpage
category: Concepts
tags: ["face", "model", "architecture", "core"]
---

# Face Model

The Face Model is the fundamental architecture of Vista's UI system. Faces are the building blocks of user interfaces, representing UI nodes with facets (visual properties) and state (data).

## Anatomy of a Face
A face consists of three main parts:

- **Type**: The kind of face (button, text, panel, etc.)

- **Attributes**: Visual properties like color, size, position

- **Children**: Nested faces for compound components

## Face Types
Vista provides various face types organized by purpose:

- **Text Faces**: text, title, subtitle, label

- **Input Faces**: field, input, textarea, select

- **Action Faces**: button, checkbox, toggle, slider

- **Container Faces**: box, panel, group, row, col, grid

- **Navigation Faces**: tabs, toolbar, menubar

- **Data Display Faces**: text-list, list, table

## Face Attributes
Attributes control the appearance and behavior of faces. They are specified using attribute labels:

`
view .html [
button "Click Me"
.color: red
.size: 120
on-click [print "clicked"]
]
`

## Common Attributes

- `id`: Unique identifier for the face

- `class`: CSS class names

- `style`: Inline CSS styles

- `data-bind`: State variable binding

## Face Tree
Faces form a tree structure with parent-child relationships. The root face contains all other faces.

`
view .html [
panel "Title" [
row [
button "Yes" []
button "No" []
]
]
]
`

## Accessing Faces
Faces can be accessed by their ID using `get-face`:

`
myButton: get-face "my-button-id"
`

## See Also

- [VID Overview](/wiki/core/concepts/vid-overview/) - The VID dialect

- [Text Components](/wiki/core/components/text-components/) - Text face types

- [Container Components](/wiki/core/components/containers/) - Panel, box, group

</ul
