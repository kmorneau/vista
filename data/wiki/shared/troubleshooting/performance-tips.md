---
title: Performance Tips
layout: docpage
category: Troubleshooting
tags: ["performance", "optimization", "tips", "speed"]
---

# Performance Tips

Optimizing Vista applications for better performance.

## Rendering Optimization
### Use Keys in Lists
❌ Don't:

list: map items => [ text item ]
✓ Do:

list: map items 'item [
  text item [ key: item\id ]
]

### Memoize Expensive Computations
expensiveCompute: => [
  ; Heavy calculation
  result: someHeavyFunction
  return: result
]

; Use memoized version
cachedResult: memoize expensiveCompute

### Lazy Load Components
; Only load when needed
heavyComponent: lazy-load "path/to/component"

; Use conditional loading
if condition [ heavyComponent ]

## State Optimization
### Use Derived State
❌ Don't:

total: 0
update: [
  total: sum allItems
]
✓ Do:

total: => sum allItems ; Computed automatically

### Batch State Updates
; Single batched update
update: [
  batch [
state.value1: newValue1
state.value2: newValue2
state.value3: newValue3
  ]
]

## Event Handling
### Use Event Delegation
; Single handler for many items
list-container [
  on:click -> handleItemClick
]

### Debounce Rapid Events
searchInput [
  on:change -> debounce [ doSearch ] 300
]

## Memory Management
### Clean Up Subscriptions
on:create [
  sub: store\subscribe \value -> handleChange
]

on:destroy [
  unsubscribe sub
]

### Clear Intervals/Timeouts
on:create [
  timer: setInterval [ tick ] 1000
]

on:destroy [
  clearInterval timer
]

## Graphics Performance
### Use requestAnimationFrame
animate: [
  requestAnimationFrame 'frame_callback
]

### Batch Canvas Operations
; Group related draw calls
canvas [
  begin-batch
  draw: item1
  draw: item2
  draw: item3
  end-batch
]

### Cache Canvas Elements
; Draw static content once
staticContent: cache-draw [
  draw: complexGraphic
]

; Reuse cached draw
canvas [
  draw: staticContent
]

## Code Splitting
; Split routes
routes: [
  "/" -> lazy "home-page"
  "/about" -> lazy "about-page"
  "/dashboard" -> lazy "dashboard-page"
]

## Profiling Checklist

- ☐ Use React/Vue devtools to identify re-renders

- ☐ Check for large bundle sizes

- ☐ Monitor memory usage over time

- ☐ Test on low-end devices

- ☐ Profile animation smoothness (60fps target)

## See Also

- [Debugging Tips](/wiki/shared/troubleshooting/debugging-tips/) - Debugging guide

- [Common Issues](/wiki/shared/troubleshooting/common-issues/) - Known issues and solutions
