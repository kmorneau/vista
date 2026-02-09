---
title: Navigation Components
layout: docpage
category: Components
tags: ["components", "navigation", "tabs", "toolbar", "menubar"]
---

# Navigation Components

Navigation components provide ways to navigate through application content and functionality.

## Tabs
`view .html [
tabs [
tab "Tab 1" [print "Tab 1 selected"]
tab "Tab 2" [print "Tab 2 selected"]
tab "Tab 3" [print "Tab 3 selected"]
]
]`

## Toolbar
`view .html [
toolbar [
button "New" [print "New"]
button "Open" [print "Open"]
button "Save" [print "Save"]
]
]`

## Menubar
`view .html [
menubar [
menu "File" [
item "Open" [print "Open"]
item "Save" [print "Save"]
]
menu "Edit" [
item "Copy" [print "Copy"]
item "Paste" [print "Paste"]
]
]
]`

## Component Features

- **Tabs**: Tab selection with content switching

- **Toolbar**: Button groups for actions

- **Menubar**: Hierarchical menu structures

## See Also

- [Button Controls](/wiki/core/components/button-controls/) - Button components

- [Click Events](/wiki/core/events/click-events/) - Event handling
