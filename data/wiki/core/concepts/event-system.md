---
title: Event System
layout: docpage
category: Concepts
tags: ["events", "handling", "core"]
---

# Event System

Vista's event system maps declarative face attributes to normalized runtime events and handler blocks.

## Event Attributes

Common attributes:
- `on-click`, `on-dblclick`
- `on-over`, `on-out`, `on-down`, `on-up`
- `on-input`, `on-change`
- `on-key`, `on-keydown`, `on-keyup`
- `on-focus`, `on-blur`
- `on-tick` (with `.rate` for timer-driven updates)

## REBOL-Style Feel Channels

Vista also supports compatibility channels:
- `engage`
- `detect`
- `redraw`

These channels can be declared with phase maps and are normalized into runtime handlers.

## Normalized Event Payload

Handler `value` includes stable keys such as:
- action metadata: `action`, `phase`, `requestedPhase`, `eventType`
- target identity: `faceId`, `targetId`, `targetName`, `targetTag`
- pointer/position: `x`, `y`, `pageX`, `pageY`, `button`, `buttons`
- keyboard/modifiers: `key`, `code`, `alt`, `ctrl`, `shift`, `meta`
- state/value: `value`, `checked`, `selectedIndex`

## Example
`
button "Submit" .on-click:[print "submit"]

field msg
.on-input:[print value\value]
`

Timer example:
`
box "Splash"
.rate:5000
.on-tick:[show_intro_splash: false show_login: true]
`

## See Also

- [Event Overview](/wiki/core/events/event-overview/) - Event categories and actions
- [VID Parity](/wiki/shared/migration/vid-parity/) - Parity status for event channels
- [Migration from REBOL View](/wiki/shared/migration/from-rebol-view/) - Compatibility details
