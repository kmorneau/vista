---
title: Face Functions
layout: docpage
category: API Reference
tags: ["face", "api", "state", "registration", "functions"]
---

# Face Functions

Face functions manage registration, lookup, metadata, and runtime facet updates.

## Core Registration API

- `next_face_id`
- `register_face`
- `current_parent_id`
- `register_face_name`
- `set_face_attrs`
- `set_face_attrs_and_name`
- `set_face_html`
- `set_face_meta`
- `with_face_id`
- `merge_faces`
- `append_children_from_root`

## REBOL-Style Facet/Actor Helpers

Migration-focused helpers include:
- `apply_facets`
- actor/facet helper mappings in the view entry layer

These helpers support runtime updates for `facets`, `feel`, and `actor` dictionaries and emit the normalized runtime attributes used by event dispatch.

## Vista State

`vista_state` tracks face and layout runtime state, including:
- counters and face registries
- face-name mappings
- last bindings/layout context
- render-time metadata

## See Also

- [Face Model](/wiki/core/concepts/face-model/) - Face architecture
- [Render Scripts](/wiki/core/api-reference/render-scripts/) - Runtime JS generation
- [VID Compatibility](/wiki/shared/migration/vid-compatibility/) - Migration mappings
