---
title: VID Overview
layout: docpage
category: Concepts
tags: ["vid", "ui", "dialect", "core"]
---

# VID Overview

VID (Visual Interface Dialect) is the declarative UI syntax used by Vista. It maps a concise block syntax to a tree of UI components.

## Concepts

- **Faces**: UI nodes with facets and state

- **Layouts**: Containers and structural grouping

- **Events**: Actions tied to widgets

## Syntax
`
view .html [
text "Label"
button "Click Me" [print "clicked"]
]
`

## References

- [Vista Tutorial](/tutorial/vista_tutorial)

- [VID Compatibility](/docs/VID_COMPAT)

- [VID Parity](/docs/VID_PARITY)

## See Also

- [Getting Started](/wiki/getting-started/) - Quick start with Vista

- [Face Model](/wiki/core/concepts/face-model/) - Understanding the face/facet architecture

- [Layout System](/wiki/core/concepts/layout-overview/) - Layout concepts and patterns
