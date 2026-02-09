---
title: Button Controls
layout: docpage
category: Components
tags: ["button", "controls", "core"]
---

# Button Controls

Button controls trigger actions when clicked.

## Basic Button
`
button "Click Me" [
print "Button clicked!"
]
`

## Button with Binding
`
button "Submit" .bind: 'submitAction [
do submitAction
]
`

## Key Button
Button styled as a keyboard key:

`
key_button "Enter"
`

## Button with Label Class
`
button "Click Me"
.label-class: "button-label"
[
print "clicked"
]
`

## Styling
`
button "Styled"
.color: blue
.size: 150
[
print "styled click"
]
`

## Example
`
view .html [
panel "Buttons" [
button "Primary" [print "Primary clicked"]
button "Secondary" [print "Secondary clicked"]
key_button "Space" [print "Space pressed"]
]
]
`

## See Also

- [Click Events](/wiki/core/events/click-events/) - Event handling

- [Keyboard Events](/wiki/core/events/keyboard-events/) - Key bindings

</ul
