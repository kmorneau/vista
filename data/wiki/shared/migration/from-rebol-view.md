---
title: Migration from REBOL View
layout: docpage
category: Shared > Migration
tags: ["migration", "rebol", "view", "rebol-view", "vid", "guide"]
---

# Migration from REBOL View

This guide helps REBOL/View developers transition to Vista. Vista inherits the declarative layout philosophy of VID while targeting modern web technologies.

## Core Philosophy

Like REBOL/View, Vista uses:

- Declarative face definitions

- Layout words (`across`, `below`, `return`)

- Data binding via word references

- Action blocks for interactivity

## Layout Keywords

### REBOL/View to Vista

REBOL/ViewVista
`across``across`
`below``below`
`return``return`
`end``end`
`pad``.pad:`
`space``.space:`

## Layout Examples

### REBOL/View
`
view layout [
across
field "Name"
button "Save" [save-data]
return
field "Email"
button "Cancel" [close]
]
`

### Vista
`
view [
across
field "Name"
button "Save" [save-data]
return
field "Email"
button "Cancel" [close]
]
`

## Face Mapping

REBOL/ViewVistaNotes
`text``text`Same syntax
`field``field`Same syntax
`button``button`Same syntax
`toggle``toggle`Same syntax
`checkbox``checkbox`Same syntax
`radio``radio`Same syntax
`slider``slider`Same syntax
`drop-list``drop-list`Same syntax
`area``textarea`Renamed
`list``text_list`Use `text_list` (list is reserved)
`panel``panel`Same syntax
`box``box`Same syntax

## Data Binding

### REBOL/View
`
name: "World"
view layout [
field name
text name
]
`

### Vista
`
name: "World"
view [
field name
text name
]
`

## Actions

### REBOL/View
`
button "Click" [print "Hello"]
`

### Vista
`
button "Click" [print "Hello"]
`

Action blocks work the same way. Vista compiles them to JavaScript.

## VID Style Features

Enable VID compatibility mode for closer REBOL/View behavior:

`
vista_layout_vid_mode: true

view [
across
text "A"
text "B"
]
`

## Draw Graphics

Vista supports Draw blocks for canvas rendering:

`
canvas .width:240 .height:140 [
pen "#1f5cff"
line-width 3
line [20 20] [200 20]
fill-pen "#f0f4ff"
box [20 40] [200 120]
]
`

## Common REBOL/View Idioms

### Skin/Feel
Vista uses CSS instead of VID skins. Use classes and styles:

`
button "Primary" .class:"btn-primary" [action]
box .style:"border: 2px solid #999" [...]
`

### Facets/Feel Compatibility
Vista now supports REBOL-like facet/feel dictionaries on faces for migration-friendly code:

`
button "OK"
.facets:#[size:[120 36] color:"#dde7ff" enabled:true]
.feel:#[click:[print "clicked"]]
`

`actor` dictionaries are also accepted and translated to `feel` handlers:

`
button "Run" .actor:#[action:[print "run"]]
`

Runtime updates can use the same model:

`
apply_facets "my-face" #[
size:[160 40]
offset:[8 4]
alpha:0.9
options:"debug"
feel:#[click:[print "clicked"]]
actor:#[engage:[print "fallback click"]]
]
`

`engage`, `detect`, and `redraw` are preserved as dedicated feel hooks (not just click/move/change aliases) and run through `data-feel-*` runtime handlers.

Phase maps are supported with pair blocks:

`
button "Run"
.feel:#[
engage:[down [status:"pressed"] click [status:"clicked"]]
detect:[move [status:"tracking"]]
redraw:[show [status:"ready"] tick [status:"refresh"]]
]
`

### Event Payload Contract (View-like feel/actor compatibility)
Feel and actor handlers now receive a normalized event object (`value`) with stable keys.

Core keys:
- `action`, `type`, `phase`, `requestedPhase`, `eventType`
- `faceId`, `targetId`, `targetName`, `targetTag`
- `timestamp`
- Position: `x`, `y`, `pageX`, `pageY`, `screenX`, `screenY`
- Delta: `dx`, `dy`
- Keyboard: `key`, `code`, `keyCode`, `which`
- Pointer/mouse: `button`, `buttons`, `pointerType`, `pointerId`, `pressure`, `tiltX`, `tiltY`, `twist`
- Wheel: `wheelX`, `wheelY`, `wheelZ`, `deltaMode`
- Modifiers: `alt`, `ctrl`, `shift`, `meta`, `modifiers`
- Target state: `value`, `checked`, `selectedIndex`

View-like action vocabulary now includes richer phases across channels:
- Engage: `down`, `up`, `click`, `double-click`, `menu`, `over`, `away`, `focus`, `blur`, `key`, `key-up`, `change`, `input`, `submit`, `wheel`
- Pointer/touch aliases: `pointer-down`, `pointer-up`, `pointer-cancel`, `enter`, `leave`, `touch-start`, `touch-end`, `touch-cancel`
- Mouse button variants: `aux-down`, `aux-up`, `alt-down`, `alt-up`
- Detect: `move`, `over`, `away`, `wheel`, `scroll`
- Redraw: `show`, `hide`, `tick`, `change`, `input`, `scroll`, `resize`

`actor` dictionaries are normalized into the same channels, including pointer/tap/long-press and drag/drop handlers.

### Style Sheets
Define reusable styles:

`
style card [
box [
title "Title"
text "Body"
]
]
`

## What's Different

- Output is HTML/WebView, not native

- No `face` object - uses DOM elements

- `show` uses JavaScript render cycle

- Some VID words are reserved in Arturo (use alternatives)

- Event system uses HTML event attributes

## Quick Reference

`
; REBOL/View
view layout [across field name button "OK" [do something]]

; Vista
view [across field name button "OK" [do something]]

; Same for:
; - field, button, text, label
; - checkbox, toggle, radio
; - slider, drop-list, select
; - box, panel, group
; - across, below, return, end
`

## See Also

- [VID Overview](/wiki/core/concepts/vid-overview/) - VID concepts in Vista

- [Getting Started](/wiki/getting-started/) - Quick start guide

- [Common Issues](/wiki/shared/troubleshooting/common-issues/) - Migration troubleshooting

## Implemented Parity and Fixes (Current)

The following migration-focused work is now implemented in Vista:

- REBOL-like facet dictionaries (`.facets:#[]`) and actor dictionaries (`.actor:#[]`) are accepted in face specs.
- Runtime facet updates are supported via `apply_facets` and related actor/facet helpers.
- `engage`, `detect`, and `redraw` are treated as first-class channels and can use phase maps (`down`, `up`, `move`, `tick`, etc.).
- Feel/actor handlers receive normalized event payloads with stable keys for position, keyboard, pointer, wheel, modifiers, and target state.
- View-like action vocabulary includes richer pointer/touch/mouse variants and redraw/detect aliases for migration parity.
- Auth/UI migration fixes include centered intro splash handling with automatic 5-second transition to login using `rate` + `on-tick`.

For API-level auth flow details and required `auth_app` state keys, see:

- [Authentication](/docs/authentication/)
