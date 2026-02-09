---
title: Mouse Events
layout: docpage
category: Events
tags: ["events", "mouse", "hover", "interactions"]
---

# Mouse Events

Mouse events are triggered when users interact with elements using the mouse pointer.

## Event Types

- **on-over**: Triggered when mouse enters the element

- **on-out**: Triggered when mouse leaves the element

- **on-down**: Triggered when mouse button is pressed

- **on-up**: Triggered when mouse button is released

## Example
`view .html [
box red 200x200 [
on-over [print "Mouse entered"]
on-out [print "Mouse left"]
on-down [print "Mouse down"]
on-up [print "Mouse up"]
]
]`

## Components Supporting Mouse Events

- All visual components

- box

- panel

- canvas

## See Also

- [Event Overview](/wiki/core/events/event-overview/) - Introduction to events

- [Click Events](/wiki/core/events/click-events/) - Click event handling
