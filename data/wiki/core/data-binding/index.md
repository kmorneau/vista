---
title: Data Binding
layout: docpage
category: Data Binding
tags: ["data-binding", "state", "reactivity", "sync"]
---

# Data Binding

Vista's data binding system enables automatic synchronization between your application state and the UI.

## Data Binding Topics

- [Binding Overview](/wiki/core/data-binding/binding-overview/) - Introduction to data binding

- [State Model](/wiki/core/data-binding/state-model/) - Managing application state

- [Two-Way Binding](/wiki/core/data-binding/two-way-binding/) - Bidirectional data flow

- Sync State - Manual state synchronization

- Auto Sync - Automatic synchronization

- Face Updates - Updating faces dynamically

## Basic Binding Example
`name: "World"
view .html [
text "Hello, "
text :name
field :name
]`

## See Also

- [State Management](/wiki/core/concepts/state-management/) - State concepts

- [Input Fields](/wiki/core/components/input-fields/) - Input components
