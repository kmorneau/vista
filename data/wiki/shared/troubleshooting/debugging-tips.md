---
title: Debugging Tips
layout: docpage
category: Troubleshooting
tags: ["debugging", "tips", "troubleshooting", "development"]
---

# Debugging Tips

Techniques for debugging Vista applications.

## Enable Debug Mode
; Enable debug logging
set-debug true

; Enable component logging
debug:components true

; Enable event logging
debug:events true

## Component Inspection
; Inspect a component
inspect myComponent

; Print component tree
print-tree root

; Show component props
show-props myComponent

## Event Debugging
; Log all events
log-events true

; Watch specific event
watch-event :click

; Trace event propagation
trace-events

## State Inspection
; Print state snapshot
snapshot state

; Watch state changes
watch state

; Diff state changes
diff-state oldState newState

## Performance Profiling
; Start profiling
profile:start

; Run your code
do: slowOperation

; Get report
profile:report

## Common Issues
### Component Not Rendering

- Check if component is mounted

- Verify render function returns a face

- Check for errors in render chain

- Ensure required props are provided

### Events Not Firing

- Verify event handler is attached

- Check if component has focus

- Ensure event bubbling is not stopped

- Check for typos in event name

### State Not Updating

- Verify state is reactive

- Check if update triggers re-render

- Ensure no circular dependencies

- Check for mutation vs assignment

## Browser DevTools

- Use Vue/React devtools if applicable

- Check console for errors

- Use network tab to debug API calls

- Use elements tab to inspect DOM

## See Also

- [Performance Tips](/wiki/shared/troubleshooting/performance-tips/) - Optimization guide

- [Common Issues](/wiki/shared/troubleshooting/common-issues/) - Known issues and solutions
