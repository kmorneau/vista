---
title: Data Display Components
layout: docpage
category: Components
tags: ["list", "table", "toolbar", "menubar", "data", "display"]
---

# Data Display Components

Data display components present collections and structured data to users.

## Text List
A simple unordered list for displaying text items:

`
text_list ["Item 1" "Item 2" "Item 3"]
`
With variable values:

`
name: "Alice"
status: "Active"
text_list [name status "Static Item"]
`

## Text List with Binding
Creates a list with data binding for dynamic updates:

`
text_list_bind [userName userStatus] bindings
`

## List Face with Binding
An interactive list with selection support:

`
list_face_bind ["Option 1" "Option 2" "Option 3"] 'selectedItem false bindings
`
For multi-select lists:

`
list_face_bind ["Tag A" "Tag B" "Tag C"] 'selectedTags true bindings
`

## Table Components
Build tables using table, row, and cell components:

### Table Container
`
table [
; Table content
]
`

### Table Sections
`
table_head [table_row [table_header_cell "Name" table_header_cell "Email"]]
table_body [
table_row [table_cell "John" table_cell "john@example.com"]
table_row [table_cell "Jane" table_cell "jane@example.com"]
]
`

### Complete Table Example
`
table .id: "users-table" [
table_head [
table_row [
table_header_cell "Name"
table_header_cell "Email"
table_header_cell "Role"
]
]
table_body [
table_row [
table_cell "Alice"
table_cell "alice@example.com"
table_cell "Admin"
]
table_row [
table_cell "Bob"
table_cell "bob@example.com"
table_cell "User"
]
]
]
`

## Toolbar
A horizontal toolbar container:

`
toolbar [
button "New"
button "Open"
button "Save"
]
`

## Menubar
A menu bar for application menus:

`
menubar [
; Menu items
]
`

## Tool Group
Groups related toolbar items:

`
toolbar [
tool_group [
button "Bold"
button "Italic"
]
tool_group [
button "Align Left"
button "Align Center"
]
]
`

## CSS Classes

- `vista-text-list` - Text list container

- `vista-list` - Interactive list

- `vista-table` - Table container

- `vista-table-row` - Table row

- `vista-table-cell` - Table cell

- `vista-table-header` - Header cell

- `vista-toolbar` - Toolbar container

- `vista-menubar` - Menubar container

- `vista-tool-group` - Tool group

- `is-active` - Active list item

- `is-selected` - Selected table row

## See Also

- [Data Binding Overview](/wiki/core/data-binding/binding-overview/) - Binding concepts

- [Container Components](/wiki/core/components/containers/) - Layout containers

</ul
