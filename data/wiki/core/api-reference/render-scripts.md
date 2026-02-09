---
title: Render Scripts
layout: docpage
category: API Reference
tags: ["render", "script", "javascript", "binding", "client"]
---

# Render Scripts

Render scripts generate the client-side JavaScript that powers data binding, state management, and UI updates in Vista applications.

## Overview
The render script system automatically generates JavaScript code that:

- Initializes client-side state from server data

- Binds input elements to state variables

- Handles two-way data synchronization

- Manages list and table interactions

- Supports keyboard navigation and accessibility

## render_script
Generates the main client-side script for a view.

`
script: render_script bindings
`
### Parameters

- `bindings` - Dictionary of state variable names to initial values

### Returns
A `` element containing the client-side code.

### Generated Functions

- `state` - Global state object

- `render()` - Updates all bound elements from state

- `bindInputs()` - Attaches event listeners to inputs

- `autoSize()` - Auto-sizes elements with data-auto-size

- `_vistaMeasureText()` - Text measurement utility

- `_vistaParsePx()` - Pixel value parser

## tabs_script
Generates JavaScript for tab component functionality.

`
script: tabs_script
`
Features:

- Click activation of tabs

- Keyboard navigation (Arrow keys, Home, End)

- Panel visibility management

## menubar_script
Generates JavaScript for menubar functionality.

`
script: menubar_script
`
Features:

- Dropdown menu toggling

- Hover activation when menu is open

- Click-outside to close

- Escape key to close

## table_script
Generates JavaScript for table row selection.

`
script: table_script
`
Features:

- Row click selection

- Visual highlighting of selected row

## auto_reload_script
Generates script for automatic page reloading (useful for development).

`
script: auto_reload_script
`
Controlled by `webview_auto_reload` and `webview_reload_ms` settings.

## WebView State Sync
When `webview_state_sync_from_ui` is enabled, the script includes:

`
window.vistaPushState = function() {
fetch('/vista-state', {
method: 'POST',
body: JSON.stringify(state)
});
};
`

When `webview_state_sync_ms` is set, periodic polling is enabled:

`
setInterval(() => {
fetch('/vista-sync')
.then(r => r.json())
.then(data => {
Object.assign(state, data);
render();
});
}, syncInterval);
`

## window.vistaShow
Global function for updating a face's HTML dynamically:

`
window.vistaShow = function(id, html) {
const el = document.querySelector('[data-face-id="' + id + '"]');
if (el) {
el.outerHTML = html;
render();
bindInputs();
return true;
}
return false;
};
`

## Data Attributes

- `data-bind` - Binds element to state variable

- `data-show-bind` - Conditional visibility binding

- `data-show-value` - Value for conditional visibility

- `data-list-bind` - List selection binding

- `data-multi` - Enable multi-select for lists

- `data-key-bind` - Keyboard input binding

- `data-key-mode` - Key event mode (keydown/keyup)

- `data-key-filter` - Filter specific keys

- `data-key-modifiers` - Capture only modifiers

- `data-face-id` - Face identifier for updates

- `data-auto-size` - Enable auto-sizing

## See Also

- [Two-Way Binding](/wiki/core/data-binding/two-way-binding/) - Data binding concepts

- [Event Overview](/wiki/core/events/event-overview/) - Event handling

</ul
