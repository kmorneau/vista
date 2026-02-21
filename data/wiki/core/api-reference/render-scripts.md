---
title: Render Scripts
layout: docpage
category: API Reference
tags: ["render", "script", "javascript", "binding", "client"]
---

# Render Scripts

Render scripts generate the client-side JavaScript for bindings, state updates, and runtime interaction handlers.

## Overview

Generated runtime code handles:
- state initialization and rendering
- input/list/table binding behavior
- key and accessibility behavior
- dynamic face updates (`vistaShow`)
- feel/actor channel dispatch through `data-feel-*` attributes

## `render_script`

Generates the main script for a view.

`
script: render_script bindings
`

## Key Runtime Functions

- `state`
- `render()`
- `bindInputs()`
- `autoSize()`
- helper utilities (`_vistaMeasureText`, `_vistaParsePx`)

## Feel/Actor Runtime Attributes

Important generated attributes include:
- `data-feel-engage`
- `data-feel-detect`
- `data-feel-redraw`
- phase-specific `data-feel-*-*` handlers
- `data-rate` with optional `data-rate-on-tick`

## Other Script Generators

- `tabs_script`
- `menubar_script`
- `table_script`
- `auto_reload_script`

## WebView State Sync

`webview_state_sync_from_ui` enables push updates from UI to Arturo.
`webview_state_push_ms` enables timed sync pushes.

## `window.vistaShow`

Global helper for replacing a face by `data-face-id` and re-binding runtime handlers.

## See Also

- [Face Functions](/wiki/core/api-reference/face-functions/) - Face registration and metadata
- [Event Overview](/wiki/core/events/event-overview/) - Event handling
- [VID Parity](/wiki/shared/migration/vid-parity/) - Compatibility channels
