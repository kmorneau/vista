---
title: Data Binding Overview
layout: docpage
category: Core > Data Binding
tags: ["binding", "data", "state", "core"]
---

# Data Binding Overview

Vista's data binding system connects your application state to UI components, enabling automatic synchronization between data and presentation. This follows the REBOL/View tradition of declarative face binding.

## How Data Binding Works

When you pass a word to a UI component, Vista automatically:

- Creates a binding between the word and the component

- Generates a state entry in JavaScript

- Sets up reactive updates when state changes

`
import 'vista!

; Define state
counter: 0
name: "World"

view [
; Text automatically updates when counter changes
text counter

; Field is bound to name - edits update state
field name

; Button action modifies state
button "Increment" [counter: counter + 1]
]
`

## Binding Types

### Text Binding
Text components display bound values that update automatically:

`
text counter
text ["Hello " name]
`

### Input Binding (Two-Way)
Field and input components support two-way binding:

`
field username        ; Bound to 'username
input .type:"email" email
textarea notes
`

### Selection Binding
List and selection components bind to selection state:

`
list choice ["Red" "Green" "Blue"]
radio color ["red" "green" "blue"]
drop-list selection ["A" "B" "C"]
`

### Boolean Binding
Checkbox and toggle components bind to boolean state:

`
checkbox accepted "Accept terms"
toggle darkMode "Dark Mode"
`

## State Synchronization

Vista provides several mechanisms for state synchronization:

### Automatic Sync (Recommended)
`
; Enable automatic periodic sync
webview_state_sync_ms: 500

; Then state syncs automatically every 500ms
counter: counter + 1
`

### Manual Sync
`
; Call sync_state after modifications
counter: counter + 1
sync_state
`

### Programmatic Updates
`
; Set state directly
set_state "counter" 42
`

## Binding Expressions

You can use expressions in bindings:

`
text ["Count: " counter]
text ["Total: " price * quantity]
text ["Valid: " if valid ["Yes"] else ["No"]]
`

## Component State

Some components have their own internal state:

`
tabs .selected:1 [
tab "One" [text "First panel"]
tab "Two" [text "Second panel"]
]
`

## See Also

- [State Model](/wiki/core/data-binding/state-model/) - Understanding Vista's state system

- [Two-Way Binding](/wiki/core/data-binding/two-way-binding/) - Input binding details

- [State Management](/wiki/core/concepts/state-management/) - Managing application state

</ul
