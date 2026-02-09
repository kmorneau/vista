---
title: Event System
layout: docpage
category: Concepts
tags: ["events", "handling", "core"]
---

# Event System

Vista's event system provides a declarative way to handle user interactions through event attributes.

## Event Attributes
Events are attached to components using event attributes:

- `on-click`: Button click

- `on-over`: Mouse enter

- `on-out`: Mouse leave

- `on-down`: Mouse down

- `on-up`: Mouse up

- `on-change`: Value change

- `on-input`: Input event

- `on-key`: Keyboard event

- `on-focus`: Focus gained

- `on-blur`: Focus lost

## Click Events
`
view .html [
button "Click Me" [
print "Button was clicked!"
]
]
`

## Mouse Events
`
view .html [
box "Hover me"
.on-over [
print "Mouse entered"
]
.on-out [
print "Mouse left"
]
]
`

## Input Events
`
view .html [
field "Type here"
.on-change [
print ["Value changed to:" fieldValue]
]
.on-input [
print ["Input:" fieldValue]
]
]
`

## Keyboard Events
`
view .html [
field .bind: 'searchText
.on-key [
if equal? searchText "escape" [
print "User pressed escape"
]
]
]
`

## Event Actions
Event blocks can contain multiple actions:

`
view .html [
button "Submit"
on-click [
print "Processing..."
do-submit
print "Done!"
]
]
`

## See Also

- [Click Events](/wiki/core/events/click-events/) - Click handling

- [Mouse Events](/wiki/core/events/mouse-events/) - Mouse interaction

- [Keyboard Events](/wiki/core/events/keyboard-events/) - Keyboard input

</ul
