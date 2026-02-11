---
title: Hello World Tutorial
layout: tutorial
category: Tutorials
tags: ["tutorial", "basics", "beginner"]
---

# Hello World Tutorial

This tutorial will guide you through creating your first Vista application.

## Prerequisites

- Arturo installed

- Vista library available

## Step 1: Import Vista
Start by importing the Vista library:

`
import 'vista!
`

## Step 2: Create Your First View
Use the `view` function to create a UI:

`
view .html [
text "Hello, World!"
]
`

## Step 3: Add Interactivity
Add a button with an action:

`
view .html [
text "Hello, World!"
button "Click Me" [
print "Button clicked!"
]
]
`

## Step 4: Run Your Application
`
arturo hello-world.art
`

## Complete Example
`
import 'vista!

view .html [
panel "My First App" [
text "Hello, World!"
button "Click Me" [
print "Hello from Vista!"
]
]
]
`

## Next Steps

- [Forms Tutorial](/wiki/core/components/input-fields/) - Building forms

- [Text Components](/wiki/core/components/text-components/) - Learn about text faces

- [Button Controls](/wiki/core/components/button-controls/) - Buttons and actions

</ul
