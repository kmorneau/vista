---
title: Animation Basics
layout: docpage
category: Animation
tags: ["graphics", "animation", "basics", "tutorials"]
---

# Animation Basics

Learn the fundamentals of creating animations in Vista Graphics.

## Animation Loop
`draw canvas [
on-frame [
frame: frame + 1
drawScene
]
]`

## Animation Principles

- **Frame Rate**: Control animation smoothness

- **Timing**: Use delta time for consistent speed

- **Easing**: Apply easing functions for natural motion

## Simple Animation
`draw canvas [
animate [
rotate: angle
drawCircle
]
]`

## Best Practices

- Use requestAnimationFrame for smooth animations

- Calculate positions based on time, not frame count

- Optimize redraw operations

## See Also

- [Frame Animation](/wiki/graphics/animation/frame-animation/) - Frame-based animation

- [Transition Effects](/wiki/graphics/animation/transition-effects/) - Transitions
