# REBOL 2 View Compatibility Checklist (Vista)

This checklist is derived from the REBOL 2 View VID and Draw dialect documentation.
Use it to track parity work while refactoring Vista.

## VID Layout Dialect
- [ ] Support all core VID styles (text, button, field, label, box, panel, list, text-list, slider, rotary, progress, toggle, check, radio, choice, icon, anim, etc.).
- [ ] Provide common VID aliases (e.g., `txt`, `lbl`, `btn`) where applicable.
- [ ] Support layout keywords: `across`, `below`, `return`, `pad`, `space`, `origin`, `offset`, `at`, `indent`, `guide`, `do`, `style`, `styles`.
- [ ] Ensure facet ordering is flexible (facets can appear in different orders).
- [ ] Support `styles` / `stylize` to define layout-local custom styles.
- [ ] Ensure `do` executes at layout build time.

## Draw Dialect (Canvas)
- [ ] Support core draw commands: `line`, `box`, `circle`, `ellipse`, `polygon`, `text`, `image`.
- [ ] Support draw state commands: `pen`, `fill-pen`, `line-width`, `line-cap`, `line-join`, `line-pattern`.
- [ ] Support transformations: `translate`, `rotate`, `scale`, `skew`, `push`, `pop`.
- [ ] Support text settings: `font`, `text-align`, `text-baseline`.
- [ ] Draw dialect should not evaluate normal code unless explicitly reduced.

## Vista-Specific Parity Notes
- [ ] Confirm VID-style facets map to Vista attrs (e.g., `backcolor` -> `color`).
- [ ] Ensure nested layout blocks inherit styles and layout scope properly.
