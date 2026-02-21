---
title: Events
layout: docpage
category: Events
tags: ["events", "handlers", "callbacks", "interactions"]
---

# Event System

Vista provides event handlers for standard UI events plus REBOL-style compatibility channels.

## Event Types

- [Event Overview](/wiki/core/events/event-overview/) - Categories and action vocabulary
- [Click Events](/wiki/core/events/click-events/) - Click and activation
- [Input Events](/wiki/core/events/input-events/) - Change and input
- [Mouse Events](/wiki/core/events/mouse-events/) - Pointer movement and buttons
- [Keyboard Events](/wiki/core/events/keyboard-events/) - Key handling
- [Focus Events](/wiki/core/events/focus-events/) - Focus transitions

## Runtime Notes

- `.on-tick` works with `.rate` for timer-driven handlers.
- `engage` / `detect` / `redraw` compatibility channels are available via feel/actor mappings.
- Event payloads are normalized for stable handler code.

## Event Example
`
button "Click Me" [print "Button clicked!"]
`

## See Also

- [Event System Concepts](/wiki/core/concepts/event-system/) - Architecture and payload model
- [VID Parity](/wiki/shared/migration/vid-parity/) - Migration parity status
