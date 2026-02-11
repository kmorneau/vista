---
title: State Management
layout: docpage
category: Concepts
tags: ["state", "binding", "data", "core"]
---

# State Management

Vista's state management system provides reactive data binding that automatically synchronizes UI state with your application data.

## The State Dictionary
The state is stored in a global dictionary where keys are binding names and values are the state data:

`
view .html [
field "Enter name" .bind: 'userName
text ["Hello " userName]
]
`

## Setting State
Use `set-state` to programmatically update state:

`
set-state 'counter 0
set-state 'name "World"
`

## Reading State
State values are accessed directly by word name:

`
currentValue: counter
print ["The counter is" counter]
`

## Two-Way Binding
Input components support two-way binding with the `.bind:` attribute:

`
view .html [
field .bind: 'username
text ["You typed: " username]
]
`

## Binding Types

- **Text Binding**: Bind to text content

- **Input Binding**: Two-way binding for input fields

- **List Binding**: Binding for list selections

- **Checkbox Binding**: Boolean state binding

## Synchronization
Use `sync-state` to push local state changes back:

`
; Automatically sync all bound values
sync-state
`

## State Callbacks
Use `on-change` to respond to state changes:

`
view .html [
field .bind: 'name
.on-change [
print ["Name changed to" name]
]
]
`

## See Also

- [Binding Overview](/wiki/core/data-binding/binding-overview/) - Complete binding guide

- [Two-Way Binding](/wiki/core/data-binding/two-way-binding/) - Input binding details

- [Auto Sync](/wiki/core/data-binding/two-way-binding/) - Automatic synchronization

</ul
