---
title: Common Patterns
layout: docpage
category: Patterns
tags: ["patterns", "best-practices", "examples"]
---

# Common Patterns

Best practices and common patterns for building Vista applications.

## Component Pattern
MyComponent: [
  on:create [
; Initialize component state
self\data: #{}
self\isLoading: true
  ]

  render: [
panel [
if self\isLoading [
text "Loading..."
]
else [
; Render content
text self\data\message
]
]
  ]
]

## State Management Pattern
; Create store
store: state #{
  count: 0
  items: []
}

; Update state
increment: [
  store.count: store.count + 1
]

; Subscribe to changes
store\subscribe \count -> print ["Count changed:" store.count]

## Event Handling Pattern
button "Click me" [
  on:click [
print "Button clicked!"
do: someAction
  ]
]

## Layout Pattern
container [
  row [
column [ text "Left" ]
column [ text "Right" ]
  ]
]

## Data Binding Pattern
inputField [
  bind: myValue
  on:change [
myValue: event\value
  ]
]

text [ display: myValue ]

## Async Pattern
loadData: async [
  response: await: fetch "/api/data"
  return: response\json
]

## Modal Dialog Pattern
showModal: [
  dialog: modal [
title: "Confirm"
body: "Are you sure?"
buttons: [
button "Cancel" [ close:dialog ]
button "OK" [ do:confirm close:dialog ]
]
  ]
]

## Form Pattern
form [
  input "Name" [ bind: formData.name ]
  input "Email" [ bind: formData.email ]
  button "Submit" [
validate: formData
submit: formData
  ]
]

## See Also

- [Anti-Patterns](/wiki/shared/patterns/anti-patterns/) - Patterns to avoid

- [State Management](/wiki/core/concepts/state-management/) - State patterns

- [Events](/wiki/core/events/event-overview/) - Event patterns
