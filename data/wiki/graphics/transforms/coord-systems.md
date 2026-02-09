---
title: Coordinate Systems
layout: docpage
category: Transforms
tags: []
---

# Coordinate Systems

Vista Graphics supports multiple coordinate systems for different use cases.

## Coordinate System Types

- **Math Coordinates**: Origin at center, Y points up

- **VID Coordinates**: Origin at top-left, Y points down

- **Canvas Coordinates**: Pixel-based positioning

## Switching Coordinate Systems
`draw canvas [
coord-system 'math
box 0 0 100 100

coord-system 'vid
box 0 0 100 100
]`

## Default System
VID coordinates are the default system in Vista.

## See Also

- [Coordinate Systems Concepts](/wiki/graphics/concepts/coordinate-systems/) - Detailed overview

- [Transforms](/wiki/graphics/transforms/) - Transform overview
