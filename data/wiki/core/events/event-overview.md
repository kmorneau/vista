---
title: Event System Overview
layout: docpage
category: Core > Events
tags: ["events", "handling", "core"]
---

# Event System Overview

Vista event handlers are declarative Arturo blocks compiled into browser runtime listeners.

## Event Categories

- Click events
- Mouse/pointer events
- Input/change events
- Keyboard events
- Focus events
- Timer events (`.rate` + `.on-tick`)

## Event Attributes

`
button "Click Me" .on-click:[print "Clicked!"]
field name .on-input:[status: "Typing..."]
`

## View-Like Compatibility Channels

Compatibility mappings support:
- `engage`
- `detect`
- `redraw`

Phase maps are supported (for example `down`, `up`, `move`, `tick`, `show`, `hide`).

## Action Vocabulary

Common action values include:
- Engage: `down`, `up`, `click`, `double-click`, `focus`, `blur`, `key`, `key-up`, `change`, `input`, `submit`, `wheel`
- Pointer/touch aliases: `pointer-down`, `pointer-up`, `touch-start`, `touch-end`, `enter`, `leave`
- Detect: `move`, `over`, `away`, `wheel`, `scroll`
- Redraw: `show`, `hide`, `tick`, `change`, `input`, `scroll`, `resize`

## Event Context

Handlers can use normalized event payload keys via `value`, including target identity, keyboard data, pointer coordinates, modifiers, and selection/value data.

## Example
`
field username .on-input:[print value\value]
`

## See Also

- [Event System](/wiki/core/concepts/event-system/) - Payload and architecture
- [VID Parity](/wiki/shared/migration/vid-parity/) - Parity matrix
