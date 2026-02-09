---
title: VID Compatibility
layout: docpage
category: Migration
tags: ["migration", "vid", "compatibility", "legacy"]
---

# VID Compatibility

Vista maintains backward compatibility with VID (View It Desktop) syntax.

## Supported VID Features

- **Face definitions**: All VID face types are supported

- **Layout keywords**: across, below, pad, space

- **Styling**: colors, fonts, sizes

- **Actions**: on-click, on-change, etc.

## Automatic Conversion
; VID syntax (automatically converted)
view [
  button "Hello" [ print "Hi" ]
  field "Enter text"
]

## Deprecated Features

Feature
Status
Alternative

vid: dialect
Deprecated
Use view directly

feel: object
Deprecated
Use on: events

facets: [...]
Deprecated
Use attribute: syntax

actor: [...]
Deprecated
Use on: events

## Compatibility Mode
; Enable full VID compatibility
useVIDCompatibility []

view/legacy [
  button "Old style" [ print "works" ]
]

## Known Differences

- Event handler syntax is more flexible in Vista

- State binding is automatic in Vista

- Layout system uses flexbox by default

## Migration Checklist

- ☐ Replace feel: with on: events

- ☐ Update actor: to on: handlers

- ☐ Remove vid: dialect wrapper

- ☐ Add state bindings where needed

## See Also

- [VID Parity](/wiki/shared/migration/vid-parity/) - Full feature comparison

- [From Rebol/View](/wiki/shared/migration/from-rebol-view/) - Migration from Rebol
