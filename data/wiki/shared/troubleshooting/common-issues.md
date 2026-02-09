---
title: Common Issues
layout: docpage
category: Shared > Troubleshooting
tags: ["troubleshooting", "issues", "problems", "debug", "help"]
---

# Common Issues

This guide covers common issues encountered when building Vista applications and their solutions.

## Data Binding Issues

### Binding Not Updating
**Problem:** UI doesn't update when state changes.

**Solution:**

- Ensure `webview_state_sync_ms` is set

- Call `sync_state` after modifications

- Verify the word is a literal token (not a string)

`
; Enable auto-sync
webview_state_sync_ms: 500

; Or manually sync
counter: counter + 1
sync_state
`

### Binding Word Not Recognized
**Problem:** "Word not bound" error or no binding generated.

**Solution:**

- Use a literal word, not a string: `field counter` not `field "counter"`

- Define the variable before calling `view`

## Layout Issues

### Elements Not Stacking
**Problem:** Elements appear horizontally instead of vertically.

**Solution:** Add layout keywords:

`
view [
below          ; Start vertical layout
text "A"
text "B"
]
`

### Spacing Issues
**Problem:** Elements are too close together.

**Solution:** Use `spacer` or layout attributes:

`
view [
across
text "A"
spacer 12
text "B"
]
`

### Reserved Word Conflicts
**Problem:** "list" causes parsing errors.

**Solution:** Use `text_list` instead of `list`:

`
; Instead of:
list ["A" "B"]

; Use:
text_list ["A" "B"]
`

## Event Issues

### Event Handler Not Firing
**Problem:** Click or input events don't trigger.

**Solution:**

- Check syntax: `.on-click:` not `on-click:`

- Ensure the block is properly formatted

`
button "Click" [
.on-click:[print "Test"]  ; Correct
]
`

### on-input vs on-change Confusion
**Problem:** Wrong event fires or events don't fire as expected.

**Solution:** Understand the difference:

- `on-input`: Fires on every keystroke

- `on-change`: Fires on blur or Enter

## Action Compilation Issues

### Complex Expressions Not Compiling
**Problem:** Action block with complex logic doesn't work.

**Solution:** Keep actions simple or split into functions:

`
; Instead of complex inline logic:
button "Process" [
result: loop 100 [complex-calculation]
saveResult
]

; Define function:
processAction [
result: loop 100 [complex-calculation]
saveResult
]

button "Process" [processAction]
`

## WebView Issues

### Window Doesn't Open
**Problem:** `view` runs but no window appears.

**Solution:**

- Check `webview_enabled: true`

- Verify HTML output with `view .html:[...]`

- Check console for errors

### DevTools Not Opening
**Problem:** Can't debug the WebView.

**Solution:** Enable debug mode:

`
webview_debug: true
`

## Style Issues

### CSS Not Applying
**Problem:** Custom styles don't appear.

**Solution:**

- Use `.style:` for inline styles

- Use `.class:` for CSS classes

- Check browser DevTools for style conflicts

`
text "Styled" .style:"color: red; font-weight: bold"
text "Classy" .class:"my-class"
`

## Canvas/Drawing Issues

### Draw Commands Not Rendering
**Problem:** Canvas is blank or Draw commands don't work.

**Solution:**

- Ensure `pen` is set before drawing

- Check coordinates are within canvas bounds

- Use `fill-pen` for filled shapes

`
canvas .width:200 .height:100 [
pen "#000"
line-width 2
line [10 10] [190 90]
]
`

## Performance Issues

### Slow Updates
**Problem:** UI feels sluggish on updates.

**Solution:**

- Increase sync interval: `webview_state_sync_ms: 1000`

- Reduce number of bound components

- Avoid expensive operations in `on-input`

## Debugging Tips

- Use `view .html:[...]` to inspect generated HTML

- Enable `webview_debug: true` for DevTools

- Use `print` statements in actions

- Check browser console for JavaScript errors

- Use `face_tree_overlay` for UI debugging

## Getting More Help

- Check the [API Reference](/wiki/core/api-reference/)

- Review [Examples](/examples/) for similar use cases

- Look for similar issues in the GitHub repository

## See Also

- [Migration Guide](/wiki/shared/migration/from-rebol-view/) - REBOL View migration

- [Event System](/wiki/core/concepts/event-system/) - Event handling

- [API Reference](/wiki/core/api-reference/) - Complete API

</ul
