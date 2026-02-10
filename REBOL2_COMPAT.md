# REBOL 2 View Compatibility Checklist (Vista)

This checklist is derived from the REBOL 2 View VID and Draw dialect documentation.
Use it to track parity work while refactoring Vista.

## VID Layout Dialect
- [x] Support core VID styles (text, button, field, label, box, panel, list, text-list, slider, rotary, progress, toggle, check, radio, choice, icon, anim, etc.).
- [x] Provide common VID aliases where applicable.
- [x] Support layout keywords: `across`, `below`, `return`, `pad`, `space`, `origin`, `offset`, `at`, `indent`, `guide`, `do`, `style`, `styles`.
- [x] Ensure facet ordering is flexible (facets can appear in different orders).
- [x] Support `styles` / `stylize` to define layout-local custom styles.
- [x] Ensure `do` executes at layout build time.

## Draw Dialect (Canvas)
- [x] Support core draw commands: `line`, `box`, `circle`, `ellipse`, `polygon`, `text`, `image`.
- [x] Support draw state commands: `pen`, `fill-pen`, `line-width`, `line-cap`, `line-join`, `line-pattern`.
- [x] Support transformations: `translate`, `rotate`, `scale`, `skew`, `push`, `pop`.
- [x] Support text settings: `font`, `text-align`, `text-baseline`.
- [ ] Draw dialect should not evaluate normal code unless explicitly reduced.
- [x] Additional draw coverage: `triangle`, `spline`, `shape`, `arrow`, `matrix`, `transform`, `reset-matrix`, `invert-matrix`, `grad-pen`, `fill-rule`, `clip`, `anti-alias`.

## Vista-Specific Parity Notes
- [x] Confirm VID-style facets map to Vista attrs (e.g., `backcolor` -> `color`).
- [x] Ensure nested layout blocks inherit styles and layout scope properly.
