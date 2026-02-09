---
title: Two-Way Binding
layout: docpage
category: Core > Data Binding
tags: ["binding", "two-way", "input", "field", "core"]
---

# Two-Way Binding

Two-way binding synchronizes data between input components and state in both directions. Changes in the UI update state, and state changes update the UI. This is fundamental to forms and interactive interfaces.

## How Two-Way Binding Works

`
import 'vista!

name: "Guest"

view [
label "Your name:"
field name           ; Binds to 'name

; This text updates as you type
text ["Hello, " name "!"]

; Action can also modify name
button "Reset" [name: "Guest"]
]
`

## Bound Input Components

### field
Text input with two-way binding:

`
field username
field "Default value"
field .placeholder:"Enter text" message
`

### input
Explicit input with type support:

`
input .type:"text" username
input .type:"email" email
input .type:"password" password
input .type:"number" quantity
input .type:"tel" phone
input .type:"search" query
`

### textarea
Multi-line text input:

`
textarea notes
textarea .rows:5 .cols:40 description
textarea .placeholder:"Enter details" details
`

## Binding Behavior

### UI to State
When user types, state updates automatically:

`
; User types in field
; State 'username updates in real-time
field username

; Action can react to changes
button "Submit" [print ["Sending: " username]]
`

### State to UI
When state changes, UI updates:

`
; This updates the field display
button "Set Name" [name: "Alice"]

; This also works
set_state "name" "Bob"
`

## Input Event Handlers

### on-input
Fires on every keystroke:

`
field search .on-input:[
print ["Searching: " search]
results: filter search
]
`

### on-change
Fires when input loses focus or Enter is pressed:

`
field email .on-change:[
print ["Email changed to: " email]
validate_email
]
`

## Input Types and Attributes

`
; Text input with validation
input .type:"email" email .placeholder:"you@example.com"

; Number input with range
input .type:"number" age .min:0 .max:150 .step:1

; Range slider
input .type:"range" volume .min:0 .max:100 .step:5

; Textarea with sizing
textarea bio .rows:4 .cols:50

; Disabled input
field readonlyValue .disabled:true
`

## Form Example

`
import 'vista!

formData: #[
name: ""
email: ""
message: ""
]

view [
form .on-submit:[submit_form] [
label "Name:"
input .type:"text" formData\name

label "Email:"
input .type:"email" formData\email

label "Message:"
textarea formData\message .rows:4

button "Submit" [submit_form]
]
]
`

## Best Practices

- Use `on-input` for real-time validation or search

- Use `on-change` for form-like interactions

- Consider using `form` component for submit handling

- Enable `webview_state_sync_ms` for smooth updates

## See Also

- [Binding Overview](/wiki/core/data-binding/binding-overview/) - Complete binding guide

- [State Model](/wiki/core/data-binding/state-model/) - Understanding state

- [Input Events](/wiki/core/events/input-events/) - Event handling for inputs

- [Input Fields](/wiki/core/components/input-fields/) - Input component reference

</ul
