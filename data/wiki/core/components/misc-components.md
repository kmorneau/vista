---
title: Miscellaneous Components
layout: docpage
category: Components
tags: ["canvas", "divider", "split", "image", "progress", "misc"]
---

# Miscellaneous Components

Additional UI components for specialized use cases including canvas drawing, visual organization, and media display.

## Canvas
An HTML5 canvas element for custom graphics:

`
canvas .id: "my-canvas" .width: 400 .height: 300
`
With draw script for rendering:

`
canvas_face .id: "drawing" .width: 200 .height: 200
; Use canvas_draw_script to generate JavaScript for the canvas
`

## Divider
A horizontal rule for visual separation:

`
divider
`
With custom styling:

`
divider .class: "thick-divider"
`

## Split View
A two-pane split layout with configurable ratio:

`
split "Left content" "Right content" 30
`
The ratio (30) means the left pane takes 30% width.

With custom attributes:

`
split
[text "Navigation"]
[text "Content"]
25
.class: "main-split"
`

## Image
Displays an image from a URL:

`
image "https://example.com/photo.png"
`
With dimensions:

`
image "photo.png" .width: 100 .height: 100
`
With data binding for dynamic images:

`
; Bind to state variable for dynamic updates
image "" .data: [bind: "profileImage"]
`

## Progress Bar
Shows completion progress (0-100):

`
progress 50
`
With data binding:

`
progress 0 .data: [bind: "uploadProgress"]
`
The bound state variable will update the progress bar automatically.

## Example
`
view .html [
title "Media Viewer"

split
[image "thumbnail.png" .width: 150]
[
subtitle "Details"
text "Image description here"
progress 75
]
30

divider

canvas .id: "preview" .width: 400 .height: 300
]
`

## CSS Classes

- `vista-canvas` - Canvas element

- `vista-divider` - Horizontal rule

- `vista-split` - Split container

- `vista-split-pane` - Individual pane in split

## See Also

- [Graphics Overview](/wiki/graphics/concepts/graphics-overview/) - Canvas drawing

- [Container Components](/wiki/core/components/containers/) - Layout containers

</ul
