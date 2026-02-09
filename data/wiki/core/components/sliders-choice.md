---
title: Sliders & Choice Components
layout: docpage
category: Core > Components
tags: ["slider", "rotary", "drop-list", "select", "choice", "range", "components"]
---

# Sliders & Choice Components

Vista provides several components for choosing values from ranges or lists: sliders, rotary dials, and drop-lists.

## Slider

Sliders allow selecting a value from a range.

### Basic Slider
`
import 'vista!

volume: 50

view [
label ["Volume: " volume]
slider volume .min:0 .max:100
]
`

### Slider with Step
`
progress: 25

view [
label ["Progress: " progress "%"]
slider progress .min:0 .max:100 .step:5
]
`

### Slider with on-input and on-change
`
value: 50

view [
label ["Value: " value]
slider value .min:0 .max:100
.on-input:[
updatePreview
]
.on-change:[
saveSetting
]
]
`

### Using input with type:range
Alternative syntax using input component:

`
brightness: 75

view [
label ["Brightness: " brightness]
input .type:"range" brightness .min:0 .max:100
]
`

## Rotary

Rotary is a knob-like slider component for selecting from discrete values.

### Basic Rotary
`
selection: 1

view [
label ["Setting: " selection]
rotary selection .min:0 .max:10
]
`

### Rotary with Step
`
speed: 50

view [
label ["Speed: " speed]
rotary speed .min:0 .max:100 .step:10
]
`

## Drop-list

Drop-lists (select) allow choosing from a dropdown list.

### Basic Drop-list
`
color: "Red"

view [
label "Choose color:"
drop-list color ["Red" "Green" "Blue"]
]
`

### Drop-list with on-change
`
choice: "Option A"

view [
drop-list choice ["Option A" "Option B" "Option C"]
.on-change:[
print ["Selected: " choice]
updateUI
]
]
`

### Drop-list with Value-Label Pairs
`
priorityId: 2

view [
drop-list priorityId [
[1 "Low Priority"]
[2 "Normal Priority"]
[3 "High Priority"]
]
]
`

### Select Component (Alias)
`select` is an alias for `drop-list`:

`
country: "US"

view [
label "Country:"
select country ["US" "CA" "UK" "DE"]
]
`

## Multiple Choice Controls

### Multiple Sliders
`
settings: #[
volume: 50
brightness: 75
contrast: 60
]

view [
label "Audio"
slider settings\volume .min:0 .max:100

label "Display"
slider settings\brightness .min:0 .max:100
slider settings\contrast .min:0 .max:100

button "Apply" [saveSettings]
]
`

### Multiple Drop-lists
`
filter: #[
category: "All"
sortBy: "name"
viewType: "grid"
]

view [
drop-list filter\category ["All" "Books" "Movies" "Music"]
drop-list filter\sortBy ["Name" "Date" "Price"]
drop-list filter\viewType ["Grid" "List"]
]
`

## Complete Example

`
import 'vista!

formData: #[
rating: 3
category: "General"
priority: 2
]

view [
text "Feedback Form"
box [
label "Rating:"
slider formData\rating .min:1 .max:5 .step:1
text ["Selected: " formData\rating "/5"]

label "Category:"
drop-list formData\category [
"General"
"Bug Report"
"Feature Request"
"Question"
]

label "Priority:"
rotary formData\priority .min:1 .max:3

button "Submit" [submitFeedback]
]
]
`

## Component Comparison

Component
Use Case
State Type

`slider`
Continuous range selection
Number

`rotary`
Discrete value selection (knob style)
Number

`drop-list`
Choose from list
String/Number

`select`
Choose from list (alias)
String/Number

## Best Practices

- Use `slider` for continuous values (volume, brightness)

- Use `slider .step:` for discrete ranges

- Use `drop-list` for categorical choices

- Use `on-input` for live preview during drag

- Use `on-change` for saving final value

- Provide labels for all choice components

## See Also

- [Selection Controls](/wiki/core/components/selection-controls/) - Checkbox and radio

- [Input Fields](/wiki/core/components/input-fields/) - Text input components

- [Input Events](/wiki/core/events/input-events/) - Event handling

</ul
