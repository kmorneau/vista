---
title: Event System Overview
layout: docpage
category: Core > Events
tags: ["events", "handling", "core"]
---

# Event System Overview

Vista's event system provides a declarative way to handle user interactions. Events are attached to components using attributes, and event handlers are Arturo blocks that are compiled to JavaScript.

## Event Categories

Vista supports several categories of events:

- **Click Events** - Button clicks, form submissions

- **Mouse Events** - Hover, enter, leave

- **Input Events** - Text changes, selection changes

- **Keyboard Events** - Key presses

- **Focus Events** - Focus gained/lost

## Event Attributes

Events are specified as component attributes:

`
button "Click Me"
.on-click:[print "Clicked!"]

field name
.on-input:[status: "Typing..."]
.on-change:[validate name]
`

## Available Events

### Click Events

`on-click`Fired when element is clicked
`on-dblclick`Fired on double-click

### Mouse Events

`on-over`Mouse enters element
`on-out`Mouse leaves element
`on-down`Mouse button pressed
`on-up`Mouse button released

### Input Events

`on-input`Fired on every keystroke (for inputs)
`on-change`Fired when value changes (blur or Enter)

### Keyboard Events

`on-key`Any key pressed
`on-keydown`Key pressed down
`on-keyup`Key released

### Focus Events

`on-focus`Element gains focus
`on-blur`Element loses focus

## Event Handler Structure

Event handlers are Arturo action blocks:

`
button "Submit" [
print "Button clicked!"
name: name + "!"
]
`

## Event Context

Event handlers have access to:

- Bound state variables

- The event target (via `this`)

- Event data (in some cases)

## Multiple Handlers

You can attach multiple handlers to the same event:

`
field username [
.on-input:[
status: "Typing..."
]
.on-change:[
validate username
status: "Done"
]
]
`

## See Also

- [Click Events](/wiki/core/events/click-events/) - Click handling details

- [Input Events](/wiki/core/events/input-events/) - Input change handling

- [Event System](/wiki/core/concepts/event-system/) - Full event reference

</ul
