---
title: Keyboard Events
layout: docpage
category: Events
tags: ["events", "keyboard", "keys", "shortcuts"]
---

# Keyboard Events

Keyboard events are triggered when users press keys on the keyboard.

## Event Types

- **on-key**: Triggered when any key is pressed

- **key**: Key binding for specific keys

## Example
`view .html [
field "Press keys here..." []
on-key [
print ["Key pressed:" event/key]
]
]`

## Key Names

- Enter, Escape, Tab

- ArrowLeft, ArrowRight, ArrowUp, ArrowDown

- F1-F12 function keys

- A-Z, 0-9 for alphanumeric keys

## Global Key Events
`; Key binding for the entire view
key "Enter" [
print "Enter pressed globally"
]`

## See Also

- [Event Overview](/wiki/core/events/event-overview/) - Introduction to events

- [Focus Events](/wiki/core/events/focus-events/) - Focus event handling
