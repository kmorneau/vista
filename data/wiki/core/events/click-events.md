---
title: Click Events
layout: docpage
category: Events
tags: ["events", "click", "button", "interactions"]
---

# Click Events

Click events are triggered when users click or tap on interactive components like buttons.

## Syntax
`component [event-handler]`

## Example
`view .html [
button "Click Me" [
print "Button clicked!"
]
]`

## Components Supporting Click Events

- button

- key_button

- checkbox (when used as toggle)

- tab

## Event Object
Click events don't provide additional event data.

## See Also

- [Event Overview](/wiki/core/events/event-overview/) - Introduction to events

- [Input Events](/wiki/core/events/input-events/) - Input event handling
