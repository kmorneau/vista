---
title: Migration
layout: docpage
category: Migration
tags: ["migration", "rebol", "compatibility", "upgrade"]
---

# Migration

Guides for migrating from REBOL/View and VID-style Vista apps.

## Migration Topics

- [From Rebol View](/wiki/shared/migration/from-rebol-view/) - Mapping REBOL/View idioms to Vista
- [VID Compatibility](/wiki/shared/migration/vid-compatibility/) - Compatibility mode and migration behavior
- [VID Parity](/wiki/shared/migration/vid-parity/) - Current feature parity and runtime notes

## Current Status

- Facet dictionaries (`.facets:#[]`) are supported.
- Actor dictionaries (`.actor:#[]`) are supported and normalized into feel channels.
- Feel channels (`engage`, `detect`, `redraw`) support phase maps.
- Event payloads are normalized for View-like handlers.
- Auth intro splash/login flow is standardized (`.rate` + `.on-tick`).

## Migration Process

- Review the migration guide for your source framework.
- Update legacy face/event declarations as needed.
- Verify event payload assumptions in handlers.
- Test migrated flows, including auth splash/login transitions.

## See Also

- [Patterns](/wiki/shared/patterns/) - Design patterns
- [Troubleshooting](/wiki/shared/troubleshooting/) - Common issues
