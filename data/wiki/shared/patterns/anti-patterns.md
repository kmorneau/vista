---
title: Anti-Patterns
layout: docpage
category: Patterns
tags: ["patterns", "anti-patterns", "avoid", "mistakes"]
---

# Anti-Patterns

Common mistakes and patterns to avoid when building Vista applications.

## Hardcoding Values
❌ Don't:

button "Submit" [
  color: #FF0000
  width: 200
  height: 50
]
✓ Do:

button "Submit" [
  color: theme.primary
  width: theme.buttonWidth
  height: theme.buttonHeight
]

## Deep Nesting
❌ Don't:

panel [
  row [
column [
panel [
row [
column [ text "Deep" ]
]
]
]
  ]
]
✓ Do:

MyCard: [
  row [ column [ text "Shallow" ] ]
]

panel [
  row [ column [ MyCard ] ]
]

## Inline Event Handlers
❌ Don't:

button "Click" [
  on:click [
do: [ 
print "clicked"
someLongAction
anotherAction
yetAnother
]
  ]
]
✓ Do:

handleClick: [
  print "clicked"
  someLongAction
  anotherAction
  yetAnother
]

button "Click" [ on:click -> handleClick ]

## Ignoring Cleanup
❌ Don't:

on:create [
  timer: setInterval [...1000]
  ; No cleanup!
]
✓ Do:

on:create [
  timer: setInterval [ doSomething 1000 ]
]

on:destroy [
  clearInterval timer
]

## Mutating Props Directly
❌ Don't:

component: [
  data: passedProp
  data.message: "Modified" ; Mutating parent state!
]
✓ Do:

component: [
  localData: copy passedProp
  localData.message: "Modified"
]

## Using Magic Numbers
❌ Don't:

position: 42 + 24 * 2 - 8
✓ Do:

padding: theme.spacing.md
position: basePosition + offset * 2 - margin

## Not Using Layout System
❌ Don't:

text "First" [ offset: 0x0 ]
text "Second" [ offset: 0x30 ]
text "Third" [ offset: 0x60 ]
✓ Do:

column [
  text "First"
  text "Second"
  text "Third"
]

## Excessive State
❌ Don't:

count: 0
doubleCount: 0
tripleCount: 0
derivedValue: 0
✓ Do:

count: 0
doubleCount: => count * 2
tripleCount: => count * 3
derivedValue: => calculateDerived count

## See Also

- [Common Patterns](/wiki/shared/patterns/common-patterns/) - Recommended patterns

- [Common Issues](/wiki/shared/troubleshooting/common-issues/) - Troubleshooting guide
