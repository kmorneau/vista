---
title: State Model
layout: docpage
category: Core > Data Binding
tags: ["state", "model", "data", "core"]
---

# State Model

Vista maintains a state object that represents the current data values for all bound components. Understanding this model is key to building reactive applications.

## State Structure

The state is a JavaScript object where each property corresponds to a bound word in your layout:

`
; Arturo code
counter: 0
name: "Alice"
accepted: false

view [
text counter
field name
checkbox accepted "Accept"
]

; Generates JavaScript state:
state = {
counter: 0,
name: "Alice",
accepted: false
}
`

## State Types

### Primitive Values
`
count: 42            ; Number
name: "Text"         ; String
active: true          ; Boolean
value: null          ; Null
`

### Arrays and Lists
`
items: ["A" "B" "C"]
selection: [0 2]     ; Multi-select
`

### Mixed Values
`
; Radio groups
color: "red"

; Tabs
tabIndex: 1
`

## Setting State

### Via Actions
Button actions can modify state directly:

`
button "Increment" [counter: counter + 1]
button "Set Name" [name: "New Name"]
button "Toggle" [active: not active]
`

### Via set_state Function
`
set_state "counter" 100
set_state "name" "Updated"
`

## Reading State

State values are accessed directly in expressions:

`
; In actions
button "Double" [counter: counter * 2]

; In conditions
if greater? counter 10 [
text "Large number!"
]

; In computed values
text ["Total: " price * quantity]
`

## State Change Detection

Vista detects state changes and triggers UI updates:

`
; Enable change detection
webview_sync_updates: true

; After modifying state
counter: counter + 1
sync_state
`

## Initial State

State is initialized from your Arturo variables:

`
; Define before view()
username: ""
email: ""
settings: #[darkMode: false notifications: true]

view [
field username
input .type:"email" email
toggle darkMode "Dark Mode"
]
`

## State Validation

You can validate state changes using on-change handlers:

`
field email .on-change:[
if not equal? email "" [
valid: contains? email "@"
]
]
`

## State Persistence

For persistent state, combine with storage:

`
; Load on start
if exists? "settings.json" [
data: read "settings.json"
settings: to :block data
]

; Save on change
button "Save" [
write "settings.json" to :string settings
]
`

## Best Practices

- Define all bound variables before calling `view`

- Use descriptive names for state variables

- Group related state into blocks or dictionaries

- Enable `webview_state_sync_ms` for automatic updates

## See Also

- [Binding Overview](/wiki/core/data-binding/binding-overview/) - Data binding concepts

- [Two-Way Binding](/wiki/core/data-binding/two-way-binding/) - Input binding

- [State Management](/wiki/core/concepts/state-management/) - State patterns

</ul
