---
title: Font Settings
layout: docpage
category: Graphics
tags: []
---

# Font Settings

Reference for Vista Graphics font configuration commands.

## Font Family
`draw canvas [
font "Arial" 16
text "Arial" 100 50

font "Times New Roman" 16
text "Times New Roman" 100 100

font "Courier New" 16
text "Courier New" 100 150
]`

## Font Size
`draw canvas [
font "Arial" 12
text "Small" 100 50

font "Arial" 24
text "Medium" 100 100

font "Arial" 36
text "Large" 100 150
]`

## Font Styles

- **bold**: Bold weight

- **italic**: Italic style

- **underline**: Underlined text

- **strike**: Strikethrough text

## Font Properties
`draw canvas [
font "Arial" 16
font-color red
font-style 'bold
text "Styled" 100 100
]`

## See Also

- [Text Rendering](/wiki/graphics/text-fonts/text-rendering/) - Text rendering

- [Typography Tips](/wiki/graphics/text-fonts/typography-tips/) - Best practices
