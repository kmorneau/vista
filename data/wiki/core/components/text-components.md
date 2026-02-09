---
title: Text Components
layout: docpage
category: Components
tags: ["text", "title", "subtitle", "label", "typography"]
---

# Text Components

Text components display textual content with appropriate semantic HTML elements and styling.

## Text
Basic inline text wrapped in a `` element:

`
text "Hello, World!"
`
HTML content is automatically escaped for safety.

## Title
Creates a main heading with `` and `vista-title` class:

`
title "Application Title"
`
With custom attributes:

`
title "Welcome" .class: "custom-title"
`

## Subtitle
Creates a secondary heading with `## ` and `vista-subtitle` class:

`
subtitle "Section Heading"
`

Label
Creates a form label with `` element:

`
label "Username:"
`
Use labels with input fields for proper form accessibility.

## Example
`
view .html [
title "My Application"
subtitle "User Profile"

panel "Details" [
label "Name:"
text "John Doe"

label "Email:"
text "john@example.com"
]
]
`

## CSS Classes

- `vista-title` - Applied to title components

- `vista-subtitle` - Applied to subtitle components

## See Also

- [Input Fields](/wiki/core/components/input-fields/) - Form inputs

- [Text Rendering](/wiki/graphics/text-fonts/text-rendering/) - Canvas text drawing

</ul
