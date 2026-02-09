---
title: Focus Events
layout: docpage
category: Events
tags: ["events", "focus", "blur", "input"]
---

# Focus Events

Focus events are triggered when elements gain or lose focus.

## Event Types

- **on-focus**: Triggered when element gains focus

- **on-blur**: Triggered when element loses focus

## Example
`view .html [
field "Focus me..." [
on-focus [print "Field focused"]
on-blur [print "Field blurred"]
]
]`

## Components Supporting Focus Events

- field

- input

- textarea

- select

## Use Cases

- Validation on blur

- Showing/hiding help text

- Tracking user activity

- Implementing keyboard navigation

## See Also

- [Event Overview](/wiki/core/events/event-overview/) - Introduction to events

- [Input Events](/wiki/core/events/input-events/) - Input event handling
