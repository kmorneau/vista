---
title: State Functions
layout: docpage
category: API Reference
tags: ["api", "reference", "state", "functions"]
---

# State Functions

Complete reference for Vista's state management functions.

## State Management

- **set-state**: Set component state value

- **get-state**: Get component state value

- **observe**: Observe state changes

- **unobserve**: Stop observing state changes

## Data Binding

- **bind**: Bind data to component

- **unbind**: Unbind data from component

- **sync**: Synchronize bound data

- **auto-sync**: Enable automatic synchronization

## State Helpers

- **computed**: Create computed value

- **derived**: Create derived state

- **watch**: Watch for state changes

## Example
`name: "World"
view .html [
text "Hello, "
text :name
field :name
]`

## See Also

- [Data Binding](/wiki/core/data-binding/) - Data binding documentation

- [Face Functions](/wiki/core/api-reference/face-functions/) - Face manipulation
