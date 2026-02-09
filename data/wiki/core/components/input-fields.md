---
title: Input Fields
layout: docpage
category: Components
tags: ["input", "field", "forms", "core"]
---

# Input Fields

Input fields allow users to enter text and other data.

## Text Field
`
field "Enter text"
`

## Bound Field
`
field .bind: 'username
`

## Text Area
`
textarea_field .bind: 'message
.rows: 5
`

## Select Dropdown
`
select_field .bind: 'country
["USA" "Canada" "UK"]
`

## Select with Labels
`
select_field .bind: 'country
["US" "United States"
"CA" "Canada"
"UK" "United Kingdom"]
`

## Password Field
`
input_field .bind: 'password
.type: "password"
`

## Number Input
`
input_field .bind: 'age
.type: "number"
.min: 0
.max: 120
`

## Event Handling
`
field .bind: 'search
.on-change [
print ["Search changed to:" search]
]
`

## Example
`
view .html [
form [
label "Name:"
field .bind: 'name

label "Email:"
input_field .bind: 'email
.type: "email"

label "Message:"
textarea_field .bind: 'message

button "Submit" [.on-click [submit-form]]
]
]
`

## See Also

- [Two-Way Binding](/wiki/core/data-binding/two-way-binding/) - Binding details

- [Input Events](/wiki/core/events/input-events/) - Event handling

- [Selection Controls](/wiki/core/components/selection-controls/) - Checkboxes, radio buttons

</ul
