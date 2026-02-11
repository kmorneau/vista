---
title: Container Components
layout: docpage
category: Components
tags: ["container", "box", "panel", "grid", "row", "col", "group", "layout"]
---

# Container Components

Container components organize and structure your UI layout. They provide the building blocks for creating complex interfaces.

## Box
A basic container with the `vista-box` class for styling:

`
box "Content goes here" .class: "my-box"
`

## Panel
A panel with optional title and body sections:

`
panel "Panel Title" [
; Panel body content
text "Content inside panel"
]
`

## Grid
A CSS grid container with specified number of columns:

`
grid 3 [
box "Cell 1"
box "Cell 2"
box "Cell 3"
box "Cell 4"
]
`
Creates a 3-column grid layout.

## Row
A horizontal flex container:

`
row [
button "Left"
button "Center"
button "Right"
]
`

## Column (col)
A vertical flex container:

`
col [
text "Top"
text "Middle"
text "Bottom"
]
`

## Group
A generic container without default styling:

`
group .id: "my-group" [
text "Grouped content"
]
`

## Spacer
Adds flexible spacing between elements:

`
row [
button "Left"
spacer
button "Right"
]
`

## Sensor
A clickable container with accessibility support:

`
sensor .onclick: "handleClick()" [
text "Click this area"
]
`
Sensors automatically add keyboard accessibility (Enter/Space) and ARIA roles.

## Example
`
view .html [
panel "Dashboard" [
grid 2 [
box "Widget 1"
box "Widget 2"
box "Widget 3"
box "Widget 4"
]
]
]
`

## See Also

- [Layout Overview](/wiki/core/concepts/layout-overview/) - Layout system concepts

- [Data Display](/wiki/core/components/data-display/) - Table and list components

</ul
