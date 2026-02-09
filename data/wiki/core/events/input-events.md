---
title: Input Events
layout: docpage
category: Events
tags: ["events", "input", "change", "field"]
---

# Input Events

Input events are triggered when users interact with input fields and other controls that accept user input.

## Event Types

- **on-change**: Triggered when the value changes and focus is lost

- **on-input**: Triggered immediately when the value changes

## Example
`view .html [
field "Enter text..." [
print "Changed to: " + value
]
textarea [
on-change [print "Final value: " + value]
on-input [print "Current: " + value]
]
]`

## Components Supporting Input Events

- field

- input

- textarea

- select

## Event Object
Input events provide access to the current value through the face's value property.

## See Also

- [Event Overview](/wiki/core/events/event-overview/) - Introduction to events

- [Input Fields](/wiki/core/components/input-fields/) - Input component reference
