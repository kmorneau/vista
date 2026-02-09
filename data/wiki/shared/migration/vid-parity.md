---
title: VID Parity
layout: docpage
category: Migration
tags: ["migration", "vid", "parity", "comparison", "feature-matrix"]
---

# VID Parity

Feature comparison between VID (View It Desktop) and Vista.

## Feature Matrix

Feature
VID
Vista
Notes

Button
✅
✅
Enhanced in Vista

Field
✅
✅
Enhanced input handling

Area
✅
✅
Multi-line support

Text
✅
✅
Rich text in Vista

Image
✅
✅
SVG support in Vista

Panel
✅
✅
Enhanced styling

Tabs
✅
✅
Dynamic tabs in Vista

Slider
✅
✅
Range sliders in Vista

Progress
✅
✅
Animated in Vista

Drop-down
✅
✅
Searchable in Vista

## Layout Features

Feature
VID
Vista
Notes

across
✅
✅
Same behavior

below
✅
✅
Same behavior

pad
✅
✅
Extended syntax

space
✅
✅
Same behavior

indent
✅
❌
Use margin/padding

guide
✅
❌
Use align attributes

center
✅
✅
Same behavior

## Event Handling

Feature
VID
Vista
Notes

on-click
✅
✅
Same syntax

on-change
✅
✅
Same syntax

on-focus
✅
✅
Same syntax

on-key
✅
✅
Enhanced key codes

on-drag
✅
✅
Enhanced in Vista

on-draw
❌
✅
Canvas events

## New Features in Vista

- **Auto-sync**: Automatic state synchronization

- **Data binding**: Declarative data flow

- **Computed state**: Derived values

- **Canvas API**: Direct drawing

- **Animation**: Built-in animation system

- **Theming**: CSS-based theming

- **Responsive**: Responsive layout support

## Deprecated in Vista

- feel: object (use on: events)

- actor: [...] (use on: handlers)

- facets: [...] (use attribute: syntax)

- vid: dialect (use view directly)

## See Also

- [VID Compatibility](/wiki/shared/migration/vid-compatibility/) - Compatibility guide

- [From Rebol/View](/wiki/shared/migration/from-rebol-view/) - Migration from Rebol
