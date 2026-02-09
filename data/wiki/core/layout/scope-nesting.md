---
title: Scope & Nesting
layout: docpage
category: Layout
tags: ["layout", "scope", "nesting", "containers", "groups"]
---

# Scope & Nesting

Understand how to properly nest and scope layouts for complex UI structures.

## Nesting Basics
`view .html [
panel [
across [
text "Left"
below [
text "Top"
text "Bottom"
]
text "Right"
]
]
]`

## Scope
`view .html [
scope [
across [
text "Scoped 1"
text "Scoped 2"
]
]
]`

## Nesting Best Practices

- Keep nesting depth reasonable (3-4 levels max)

- Use scope to isolate layout contexts

- Group related components together

- Consider using named faces for complex hierarchies

## See Also

- [Across & Below](/wiki/core/layout/across-below/) - Basic layout

- [Containers](/wiki/core/components/containers/) - Container components
