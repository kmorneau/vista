# Vista UI Framework (Arturo) — Detailed Documentation

This document explains how the Vista UI framework works, how to use it, and how its Rebol/View-inspired syntax maps to HTML and WebView output.

Vista is a small, declarative UI layer written in Arturo. It parses a block layout and generates HTML + JavaScript. The result is rendered in a desktop window via Arturo's `webview`.

## Quick Start

```arturo
import 'vista!

counter: 0

view [
    text "Count:"
    field counter
    button "Increment" [counter: counter + 1]
]
```

Running this script:
- Generates `ui.html` in the current directory
- Opens a WebView window showing the UI
- Updates `counter` in state when you click the button

If you want to render from a file path instead of inline HTML, use the `.file:` option:

```arturo
view .file: "ui.html" [
    text "Count:"
    field counter
    button "Increment" [counter: counter + 1]
]
```

If you only want the raw HTML (no webview), use `.html`:

```arturo
html: view .html [
    text "HTML only"
]
```

## Files

- `vista.art`: The framework implementation
- `examples/`: Runnable demo scripts
- `ui.html`: Generated output (created by `view`)

## Core Concepts

### 1. Layout Blocks

Vista uses a block to describe UI structure, similar to Rebol/View:

```arturo
view [
    text "Hello"
    field name
    button "Submit" [name: name + "!"
]
```

Each word in the block is a **face** (a UI element). Arguments follow each face until another face keyword appears.

### 2. Faces (UI Elements)

Supported faces:

- `text <value>`
- `field <word|value>`
- `button <label> <action>`
- `label <value>`
- `box <block|string>`
- `panel <title?> <block>` (box with header)
- `text_list <block|value>` (use underscore; `text-list` is parsed as subtraction in Arturo)
- `list <block|value>` (alias for `text_list`)
- `row <block|string>`
- `col <block|string>`
- `grid <cols?> <block>` (CSS grid)
- `spacer <size?>` (blank space)
- `table <block>` with `table-row` / `table-cell`
- `toolbar <block>` / `menubar <block>`
- `canvas` (raw HTML canvas)
- `divider` (horizontal rule)
- `split <left> <right>` (side-by-side panels)
- `group <block|string>` (generic wrapper)
- `title <value>` / `subtitle <value>`
- `form <block> <action?>` (or `.on-submit:` attribute)
- `checkbox <word> <label?>`
- `toggle <word> <label?>`
- `input <word|value>` (use `.type:` for `number`, `password`, `range`, etc.)
- `slider <word|value>` (range input with `vista-slider` class)
- `textarea <word|value>`
- `select <word|value> <options?>`
- `drop-list <word|value> <options?>` (alias for `select`)
- `radio <word|options> <options?>` (also `radio-group` / `radio_group`)
- `tabs <block>` (with `tab <title> <block>`)
- `image <word|value>`
- `progress <word|value>`
- layout words: `across`, `below`, `return`, `end`

#### text

```arturo
text "Hello"
text someWord
```

- If you pass a word, it becomes data-bound to state and updates live.

#### field

```arturo
field name
field "static"
```

- If you pass a word, it becomes an editable input bound to state.
- If you pass a literal value, it renders a static input with that value.

#### button

```arturo
button "Click" [counter: counter + 1]
```

- The label can be a string or a data-bound word.
- The action is a block that is compiled into JavaScript and executed on click.

#### label

```arturo
label "Name"
label someWord
```

Like `text`, but rendered as `<label>`.

#### box

```arturo
box [
    text "Inside"
    field value
]
```

Wraps nested layouts into a styled `<div class='vista-box'>`.

#### panel

```arturo
panel "Title" [
    text "Body"
]
```

Panel is a box with a header and body.

#### text_list

```arturo
text_list ["Item A" "Item B"]
```

Renders `<ul class='vista-text-list'>` with `<li>` entries.

#### list (alias)

```arturo
list ["Item A" "Item B"]
```

Same as `text_list`.

#### row / col

```arturo
row [
    text "Left"
    text "Right"
]
col [
    text "Top"
    text "Bottom"
]
```

Adds flexbox wrappers with `vista-row` and `vista-col` classes.

#### grid

```arturo
grid 3 [
    text "A"
    text "B"
    text "C"
]
```

Creates a CSS grid with `cols` columns. You can also set `.cols:`.

#### spacer

```arturo
spacer 12
spacer [20 8]
```

Adds vertical or size-based spacing.

#### table

```arturo
table [
    table-row [table-cell "A" table-cell "B"]
]
```

## Rebol/View → Vista Quick Translations

These patterns map common VID idioms to Vista.

1. VID skin + layout mode:

```arturo
vista_vid_mode: true
vista_layout_vid_mode: true
view [
    text "VID-style view"
]
```

2. Across / below layout:

```arturo
across
text "Left"
text "Right"
return
below
text "Top"
text "Bottom"
```

3. Face + data binding:

```arturo
name: "Ada"
field name
text name
```

4. Actions on events:

```arturo
button "Save" [status: "Saved"]
field name .on-input:[status: "Typing..."]
```

5. Panels and groups:

```arturo
panel "Settings" [
    checkbox enabled "Enable"
]
group [
    text "Ungrouped content"
]
```

6. HTML escape vs raw:

```arturo
text "<b>Escaped</b>"
raw "<b>Raw HTML</b>"
```

## State + Events Best Practices

1. Bind words for live updates:

```arturo
count: 0
text count
```

2. Prefer `.on-input` for fields and `.on-change` for selects:

```arturo
field name .on-input:[status: "Typing..."]
drop-list choice ["A" "B"] .on-change:[status: "Changed"]
```

3. Use `data-show` bindings for conditional UI:

```arturo
panel .data-show-bind:"mode" .data-show-value:"advanced" [
    text "Advanced settings"
]
```

4. Keep actions small and state-driven:

```arturo
button "Increment" [count: count + 1]
```

5. Avoid mixing HTML into text unless you need it:

```arturo
text "Safe by default"
raw "<em>Intentional markup</em>"
```

Creates an HTML table.

#### toolbar / menubar

```arturo
toolbar [button "Save" [saved: true]]
menubar [text "File" text "Edit"]
```

Simple horizontal bars for actions or menus.

#### canvas

```arturo
canvas .width: 200 .height: 100
```

Renders a `<canvas>` element.

You can also pass a Draw block (Rebol/View-style) as the first argument to render HTML5 Canvas graphics:

```arturo
canvas .id:"demo" .width: 240 .height: 140 [
    pen "#1f5cff"
    line-width 3
    line [20 20] [200 20]
    fill-pen "#f0f4ff"
    box [20 40] [200 120]
]
```

Draw is implemented in [`vista-graphics.art`](vista-graphics.art:1) and runs client-side.

#### divider

```arturo
divider
```

Renders a horizontal rule.

#### split

```arturo
split .ratio: 40 [
    text "Left"
] [
    text "Right"
]
```

Creates a two-pane horizontal split. `.ratio:` is the left pane percent.

#### checkbox

```arturo
checkbox accepted "Accept terms"
```

Creates a bound checkbox. The bound word becomes a boolean in state.

Label can also be a block:

```arturo
checkbox accepted [
    text "Accept "
    label .class:"muted" "terms and conditions"
]
```

#### toggle

```arturo
toggle darkMode "Dark Mode"
```

A stylized checkbox (toggle switch) bound to a boolean.

Label can also be a block (same as `checkbox`).

#### group

```arturo
group .class:"panel" .style:"padding:12px" [
    text "Wrapped content"
]
```

Generic wrapper for grouping and styling.

#### input

```arturo
input .type:"number" age
input .type:"password" secret
input .type:"range" .min:0 .max:100 volume
```

Same as `field`, but explicit `type` and extra attributes (min/max/step/etc.).

#### slider

```arturo
slider level .min:0 .max:10
```

Range input with a default type of `range`.

#### textarea

```arturo
textarea notes .rows:3 .cols:24
```

Multi-line input bound to state.

#### select

```arturo
select choice ["Red" "Green" "Blue"]
select choice [[1 "Low"] [2 "Medium"] [3 "High"]]
```

Options can be plain values or `[value label]` pairs.

#### drop-list (alias)

```arturo
drop-list choice ["Red" "Green" "Blue"]
```

Same as `select`.

#### radio / radio-group

```arturo
radio choice ["Red" "Green" "Blue"]
radio-group choice [[1 "Low"] [2 "Medium"] [3 "High"]]
```

Creates a radio group bound to a single state key.

Radio labels can be full blocks:

```arturo
radio choice [
    ["a" [text "Alpha"]]
    ["b" [text "Beta"]]
]
```

Radio options can also include per-option attributes as a third value:

```arturo
radio choice [
    ["a" "Alpha" #[disabled: true]]
    ["b" "Beta" #[]]
]
```

#### tabs

```arturo
tabs [
    tab "Overview" [
        text "Welcome"
    ]
    tab "Details" [
        field details
    ]
]
```

Tabs render a button bar and panels. The first tab is active by default.

#### image

```arturo
image "https://example.com/preview.png" .alt:"Preview"
image photoUrl .alt:"Bound image"
```

If you pass a word, it becomes a bound `src`.

#### progress

```arturo
progress 40 .max:100
progress percent .max:100
```

Renders a HTML `<progress>` element, optionally bound to state.

### 3. Layout Flow Keywords

These keywords affect layout and grouping:

- `across` — starts a flex row
- `below` — starts a new stacked container
- `return` — ends a row and starts a new row
- `end` — closes the most recent `across`/`below` container

Example:

```arturo
view [
    across
    text "Left"
    text "Right"
    return
    text "New line"
]
```

You can explicitly close groups with `end` (useful for nesting):

```arturo
view [
    across
    text "Left"
    below
    text "Inner"
    end
    text "Right"
    end
]
```

### Rebol/View Mapping (Quick Reference)

Vista borrows the flow of Rebol/View while targeting HTML:

- `across` → start horizontal row
- `below` → start vertical group
- `return` → new row in current group
- `end` → close current group

Additional VID-style layout words apply to the *next face* (or the next
layout container created by `across`, `below`, or `return`):

- `pad` → padding on the next face
- `space` → gap on the next face
- `align` → align-items on the next face
- `valign` → justify-content + vertical-align on the next face
- `size` → width/height on the next face
- `origin` → relative positioning on the next face
- `offset` → relative positioning on the next face
- `indent` → margin-left on the next face
- `guide` → adds a dashed outline to the next face
- `do` → evaluates a block without emitting a face
- `scope` → applies current layout words to all faces inside a block

For closer Rebol/View layout behavior, enable:

```arturo
vista_layout_vid_mode: true
```

This switches `across`, `below`, and `return` to VID-like flex rows/columns.

Example:

```arturo
view [
    across
    text "Name"
    field name
    return
    text "Email"
    field email
    end
]
```

Scoped layout example:

```arturo
pad 12
scope [
    across
    text "A"
    text "B"
]
```

Scoped layout with explicit attributes:

```arturo
scope .pad:8 .space:12 [
    across
    text "One"
    text "Two"
]
```
### Raw HTML helper

Vista escapes text by default. If you need to intentionally render HTML,
wrap the content with `raw`:

```arturo
view [
    text "<em>escaped</em>"
    return
    raw "<strong>not escaped</strong>"
]
```

### Styles

You can define reusable styles with `style` and invoke them like faces:

```arturo
style card [
    box [
        title "Card Title"
        text "Card body"
    ]
]

view [
    card "Card Title" "Card body"
]
```

Styles are expanded inline, so they behave like reusable layout blocks.
Style arguments are available as `arg0`, `arg1`, ... and `args` (all arguments):

```arturo
style card [
    box [
        title arg0
        text arg1
    ]
]
```

### VID Style Aliases

Vista provides common Rebol/View-style aliases so VID examples translate cleanly:

- `h1`..`h5`, `vh1`..`vh3`, `banner`
- `info`, `area`, `choice`, `check`
- `key`
- `icon`, `anim`, `rotary`, `sensor`
- `tt`, `code`, `vtext`
- `icon`, `anim`, `arrow`, `rotary`, `led`, `sensor`
- `backdrop`, `backtile`

These map to existing HTML faces with lightweight CSS classes.

### Facets (MVP)

You can pass basic facets as attributes:

```arturo
text .color:"#f0f0f0" .font:#[size: 18 color: "#333" family: "Georgia"] "Hello"
box .edge:#[size: 2 color: "#999" style: "dashed"] [
    text .para:"center" "Centered"
]
```

Supported facet keys:

- `color` → background color
- `font` → `family`, `size`, `color`, `weight`, `style`
- `para` → `align`, `wrap`, `spacing`, `leading`
- `edge` → `size`, `color`, `style`, `radius`
- `effect` → `shadow` or CSS filter string

`edge` styles also accept `bevel`, `raised`, and `inset` for classic VID looks.

Event helpers:

- `on-over`, `on-out`
- `on-down`, `on-up`

`effect` also supports `inset`, `raised`, `emboss`, and `bevel`.


### Key Capture

Use `key` to capture keystrokes into state:

```arturo
key lastKey "Press a key"
text lastKey
```

You can react to key changes with `.on-change`:

```arturo
key lastKey .on-change:[print lastKey] "Press a key"
```

Key options:

- `.mode:"keydown"` or `.mode:"keyup"`
- `.modifiers:true` to capture only modifiers
- `.filter:["A" "B" "C"]` to restrict to specific keys

Keys update `state.lastKey` in the WebView. To sync changes back into
Arturo variables, enable:

```arturo
webview_state_sync_from_ui: true
```

### List Selection

Lists can bind selection to state:

```arturo
list choice ["One" "Two" "Three"]
```

Multi-select:

```arturo
list choice .multi:true ["One" "Two" "Three"]
```

List keyboard navigation:

- Arrow keys move selection
- Home/End jump to start/end
- Enter/Space toggles selection (multi-select)
- Typing letters jumps to the first matching item
- `Ctrl`/`Cmd` moves the active row without changing selection
- `Shift` extends the selection range (multi-select)

### VID Widgets (Phase 3)

`info` is a read-only field:

```arturo
info statusText
```

`rotary` is a knob-like slider (range input):

```arturo
rotary volume
```

`icon` and `anim` are image faces with default sizing:

```arturo
icon "icon.png"
anim "spinner.gif"
```

`sensor` is a hover/clickable container (use events):

```arturo
sensor .on-click:[print "tap"] [
    text "Hover or click me"
]
```

### App Header Metadata

If your script defines an `ARTURO [...]` header, Vista will auto-apply it.

Example:

```arturo
ARTURO [
    Title: "Digital Clock"
    Version: 1.3.3
    Author: "Keith Morneau"
    Purpose: "Display a simple digital clock on screen."
    Width: 480
    Height: 320
]
```

Vista will use `Title` for the window title, and `Width`/`Height` if provided.

## Release & Migration

See `RELEASE_NOTES.md` for changes and usage updates.
Lists now also highlight the active row on keyboard navigation, and
hover/pressed states are styled for clearer feedback.

### Face Registry and `show`

Every face created during layout is stored in a registry (`vista_state\last_faces`).
You can use `show` to retrieve the HTML for a face by id:

```arturo
html: view .html [
    text "Hello"
]
ids: keys vista_state\last_faces
print show (get ids 0)
```

You can also name faces using `.id:` and fetch them by name:

```arturo
view [
    text .id:"greeting" "Hello"
]

update_face "greeting" #[text: "Hello again"]
```

When the HTML is rendered in a WebView, every face includes a
`data-face-id` attribute. You can use the injected JS helper to live-update:

```js
window.vistaShow(faceId, "<div data-face-id='...'>...</div>")
```

You can also query and update faces in Arturo:

```arturo
face: get_face "face-1"
update_face "face-1" #[text: "Updated"]
```

If you want `update_face` to push changes into the WebView automatically,
enable `webview_sync_updates`:

```arturo
webview_sync_updates: true
```

If you want to update bound state from Arturo and re-render the UI,
enable `webview_sync_state_updates` and call `set_state`:

```arturo
webview_sync_state_updates: true
set_state "counter" 42
```

If you mutate bound variables directly in Arturo, you can call `sync_state`
to detect changes and refresh the WebView without manually calling `set_state`:

```arturo
counter: counter + 1
sync_state
```

### Face Paths

You can navigate the face tree with `get_face_path` using a path list:

```arturo
; ["panel" 0 "title" 0] = first panel, first title within it
face: get_face_path ["panel" 0 "title" 0]
print show face
```

You can update faces by path as well:

```arturo
update_face_path ["panel" 0 "title" 0] #[text: "Updated Title"]
```

Convenience helpers:

```arturo
first: path_first ["panel" 0]
last: path_last ["panel" 0]
nth: path_nth ["panel" 0] 1
```

You can also target faces by `.id:` in a path:

```arturo
face: get_face_path [".id:greeting"]
print show face
```

### Tabs: Update a Single Panel

You can update a single tab panel by index:

```arturo
tabsFace: get_face_path ["tabs" 0]
update_tab_panel tabsFace\id 1 [
    text "Updated panel"
]
```

You can set the initial active tab with `.selected`:

```arturo
tabs .selected:1 [
    tab "One" [text "First"]
    tab "Two" [text "Second"]
]
```

### Debugging Helpers

You can print the current face tree:

```arturo
print_face_tree
```

For an in-UI inspector, add:

```arturo
face_tree_overlay
```

The overlay includes search, click-to-highlight, and a live state inspector.

You can also search faces by criteria:

```arturo
find_faces #[type: "text"]
find_faces #[id: "greeting"]
find_faces #[attr: "data-face-id"]
```

If you only need the first match, use `find_face`:

```arturo
face: find_face #[id: "greeting"]
print face_info face
```

`face_info` returns a compact string for a face (id, type, and optional `.id`).

If you need a tree snapshot for debugging or external tooling, use `face_tree` (object) or `face_tree_json` (JSON string):

```arturo
tree: face_tree
print tree
print face_tree_json
```

For readable JSON during debugging, use:

```arturo
print face_tree_pretty
```

To dump a subtree by `.id`:

```arturo
print face_tree_by_id #[id: "greeting"]
print face_tree_by_id_json #[id: "greeting"]
print face_tree_by_id "greeting"
```

To overlay the current face tree directly in the UI, add:

```arturo
face_tree_overlay
```

Other helpers for composite faces:

```arturo
update_panel_body panelFace\id [text "New body"]
update_split_pane splitFace\id 1 [text "Right updated"]
update_table_body tableFace\id [table-row [table-cell "C" table-cell "D"]]
```

### Auto State Sync

To auto-sync state from Arturo into the WebView on an interval, set:

```arturo
webview_state_sync_ms: 500
```

This injects a small polling loop in the WebView and serves `/vista-sync`
from the Arturo process to fetch the latest `vista_state\last_bindings`.

## Data Binding Model

Vista builds a `state` object in JavaScript. Every word passed to `text`, `label`, `field`, or as a button label becomes a bound key in that state.

Example:

```arturo
counter: 0
view [
    text counter
    field counter
]
```

Generates:

- `state.counter` in JS
- `<span data-bind='counter'>...</span>`
- `<input data-bind='counter'>...`

Whenever the state changes, the UI re-renders automatically.

## Actions and Expression Compilation

Button actions are Arturo blocks and are compiled into JavaScript. Example:

```arturo
[counter: counter + 1]
```

Becomes:

```js
state.counter = state.counter + 1; render();
```

Rules:

- Labels like `counter:` are parsed as assignments
- Expressions are tokenized and converted to JS
- Words become `state.<word>`

## WebView Integration

`view` generates HTML and then launches Arturo’s WebView.

### HTML-only mode

You can generate HTML without opening a WebView by using `.html`:

```arturo
html: view .html [
    text "Hello"
]
```

### No WebView mode

If you want to skip opening a window entirely, use `.noWebview`:

```arturo
view .noWebview [
    text "Headless build"
]
```

### Inline HTML mode (default)

```arturo
webview .title: webview_title .width: webview_width .height: webview_height fullHtml
```

### File-based mode (`.file:`)

If you pass `.file:`, Vista writes the HTML to that path and opens WebView using a `file://` URL:

```arturo
view .file: "ui.html" [
    text "Hello"
]
```

### WebView options

You can configure default window options by setting these globals before calling `view`:

```arturo
webview_title: "My App"
webview_width: 800
webview_height: 500
webview_debug: true
webview_enabled: true
webview_auto_reload: false
webview_reload_ms: 1000
```

When `webview_debug` is true, DevTools opens automatically.

If `webview_enabled` is false, `view` will generate HTML but not open a window.
If `webview_auto_reload` is true, the HTML includes a timer that reloads the page.

## Attributes

You can add HTML attributes using Arturo attribute labels:

```arturo
text .class:"title" .style:"font-weight:700" "Heading"
field .placeholder:"Your name" name
button .class:"primary" "Save" [saved: true]
```

Common attributes:

- `.class:` / `.style:`
- `.disabled:` / `.hidden:` for any face
- `.placeholder:` for inputs
- `.min:` / `.max:` / `.step:` for `range` or `number` inputs
- `.label-class:` to style labels on `button`, `checkbox`, and `toggle`
- `.on-click:` / `.on-change:` / `.on-key:` / `.on-input:` / `.on-focus:` / `.on-blur:` for event handlers
- `.pad:` / `.space:` / `.align:` / `.size:` for layout styling
- `.origin:` / `.offset:` / `.at:` for positioning (`.at` uses `position: absolute`)

## Rendering Pipeline

`view` executes this sequence:

1. `layout_state` parses the block into HTML + bindings
2. `render_script` generates JS for:
   - `state` object
   - `render()` to update DOM
   - `bindInputs()` for input events
3. HTML + CSS + JS are assembled into `fullHtml`
4. If `.file:` is provided, `fullHtml` is written to that path; otherwise it writes to `ui.html`
5. WebView opens either with inline HTML or the `file://` URL

## Extending Vista

To add a new face type:

1. Add the face name to `is_keyword`
2. Extend the `layout_state` switch with a new block
3. Optionally add helper functions for HTML generation

Example: `text_list` was implemented this way.

## Known Limitations

- Layout keywords are minimal (`across`, `below`, `return`)
- There is no advanced styling system (only inline CSS + small defaults)
- Complex expressions may not compile to JS perfectly
- Radio groups are simple and do not support per-option bindings
- Positioning uses basic CSS and does not fully mimic Rebol/View layout

## Tips

- Always load the framework using `import 'vista!` (not `do read`)
- Use words (not strings) for bindings
- If a binding isn’t updating, verify it is a word token in the layout block

## Example: Counter (Full)

```arturo
import 'vista!

counter: 0

webview_title: "Counter Demo"
webview_width: 640
webview_height: 360

view [
    text "Count: "
    text counter
    field counter
    button "Increment" [counter: counter + 1]
]
```

### Example: Counter (File Mode)

```arturo
import 'vista!

counter: 0

webview_title: "Counter Demo"
webview_width: 640
webview_height: 360

view .file: "ui.html" [
    text "Count: "
    text counter
    field counter
    button "Increment" [counter: counter + 1]
]
```

That’s it—simple declarative UI with live binding and WebView rendering.

## Example Gallery (Simple to Complex)

### 1) Hello World (Text + Label)

```arturo
import 'vista!

view [
    text "Hello, Vista!"
    label "This is a label"
]
```

### 2) Simple Input Echo

```arturo
import 'vista!

name: "Ada"

view [
    label "Name:"
    field name
    text "You typed:"
    text name
]
```

### 3) Counter with Button

```arturo
import 'vista!

counter: 0

view [
    text "Count:"
    text counter
    button "Increment" [counter: counter + 1]
]
```

### 4) Boxed Form with Layout Flow

```arturo
import 'vista!

first: "Grace"
last: "Hopper"

view [
    text "Profile"
    box [
        across
        label "First:"
        field first
        return
        label "Last:"
        field last
    ]
    text "Preview:"
    text first
    text last
]
```

### 5) Simple Checklist + Actions

```arturo
import 'vista!

item1: "Learn Arturo"
item2: "Build UI"
item3: "Ship Demo"

view .file: "ui.html" [
    text "Todo:"
    text_list [item1 item2 item3]
    button "Add exclamation" [
        item1: item1 + "!"
        item2: item2 + "!"
        item3: item3 + "!"
    ]
]
```

For a combined layout + controls example, see `examples/06-controls-layout.art`.
For grouping and block labels, see `examples/07-group-and-labels.art`.
For forms and headings, see `examples/08-form-title.art`.
For sliders and radio groups, see `examples/09-radio-slider.art`.
For images and progress, see `examples/10-image-progress.art`.
For tabs, see `examples/11-tabs.art`.
For radio labels as blocks, see `examples/12-radio-block-labels.art`.
For events, see `examples/13-events.art`.
For positioning, see `examples/14-layout-positioning.art`.
For slider labels, see `examples/15-slider-labels.art`.
For list/drop-list, see `examples/16-lists.art`.
For panels and grids, see `examples/17-panel-grid.art`.
For spacers, see `examples/18-spacer.art`.
For tables, see `examples/19-table.art`.
For toolbars/menubars, see `examples/20-toolbar-menubar.art`.
For canvas + divider, see `examples/21-canvas-divider.art`.
For split layouts, see `examples/22-split.art`.
For radio option attrs, see `examples/23-radio-attrs.art`.

## Tests and Snapshots

There is a lightweight regression suite under `tests/` that generates HTML only.

Run the snapshot generator:

```arturo
arturo tests/run_tests.art
```

Snapshots are written to `tests/snapshots/snapshots/`.
#### title / subtitle

```arturo
title "Dashboard"
subtitle "Recent activity"
```

Titles are styled headings (`h1`/`h2`) and can be data-bound.

#### form

```arturo
form .on-submit:[submitted: true] [
    label "Email"
    input .type:"email" email
    button "Save" [submitted: true]
]
```

You can also pass the submit action as a second block:

```arturo
form [
    input .type:"text" name
] [
    submitted: true
]
```
