---
title: Transition Effects
layout: docpage
category: Animation
tags: ["graphics", "animation", "transitions", "effects"]
---

# Transition Effects

Vista Graphics supports smooth transition effects for UI and graphics.

## Easing Functions

- **linear**: Constant speed

- **ease-in**: Accelerate

- **ease-out**: Decelerate

- **ease-in-out**: Accelerate then decelerate

- **bounce**: Bounce effect

## Basic Transition
`animate [
position: lerp start end t ease-out
drawObject position
]`

## Color Transition
`animate [
color: lerpColor red blue t
fill color
]`

## See Also

- [Animation Basics](/wiki/graphics/animation/animation-basics/) - Fundamentals

- [Particle Systems](/wiki/graphics/animation/particle-systems/) - Particle effects
