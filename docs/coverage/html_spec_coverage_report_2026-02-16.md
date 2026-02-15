# Vista + Vista Graphics Coverage vs WHATWG HTML Living Standard

Date: 2026-02-16

## Scope and method

This report evaluates Vista (`src/vista/modules`) and Vista Graphics (`src/vista/graphics`) against major feature areas in the WHATWG HTML Living Standard (multipage edition).

Sources used:
- WHATWG HTML Living Standard (multipage): https://html.spec.whatwg.org/multipage/
- Forms: https://html.spec.whatwg.org/multipage/forms.html
- Grouping/content model areas: https://html.spec.whatwg.org/multipage/grouping-content.html
- Tables: https://html.spec.whatwg.org/multipage/tables.html
- Interaction and interactive elements: https://html.spec.whatwg.org/multipage/interaction.html
- Drag and drop: https://html.spec.whatwg.org/multipage/dnd.html
- Canvas and 2D context model: https://html.spec.whatwg.org/multipage/canvas.html
- Custom elements: https://html.spec.whatwg.org/multipage/custom-elements.html
- DOM/global model context: https://html.spec.whatwg.org/multipage/dom.html
- Parsing/document model context: https://html.spec.whatwg.org/multipage/parsing.html

Repository evidence used:
- Coverage matrix: `docs/coverage/html5_vista_coverage_matrix.md`
- VID tracker: `docs/coverage/rebol_view_vid_coverage.csv`
- Draw tracker: `docs/coverage/rebol_draw_coverage.csv`
- Coverage gate script: `tests/check_feature_coverage.art`

Notes:
- This is a feature-surface coverage report, not a formal conformance certification against every algorithm in the spec.
- Status values are from the repo matrix and verified against current tests/tooling.

## Coverage summary

### HTML core surface (Vista)
- Total mapped areas: 14
- Full: 7 (50.0%)
- Partial: 6 (42.9%)
- Gap: 1 (7.1%)

### Graphics surface (Vista Graphics / Canvas-oriented)
- Total mapped areas: 17
- Full: 9 (52.9%)
- Partial: 6 (35.3%)
- Gap: 2 (11.8%)

### Combined
- Total mapped areas: 31
- Full: 16 (51.6%)
- Partial: 12 (38.7%)
- Gap: 3 (9.7%)

## Current test-backed signals

- Feature token gate passes:
  - Vista core: 64 required tokens present
  - Vista graphics: 42 required tokens present
  - From: `arturo tests/check_feature_coverage.art`
- Tracker counts:
  - VID: 50 `yes`, 5 `partial` (`docs/coverage/rebol_view_vid_coverage.csv`)
  - Draw: 39 `yes`, 3 `partial` (`docs/coverage/rebol_draw_coverage.csv`)

## Area-level assessment

### Vista (HTML-core aligned)
- Strong coverage:
  - Document shell and metadata emission
  - Layout/grouping containers and table/list rendering
  - Form control surface and binding/event integration
  - Generic attribute passthrough for custom/global attrs
- Partial coverage:
  - Heading/text semantics are mostly style/container-oriented
  - Media support is element-level, but advanced media semantics are thin
  - `dialog`/`details`/`summary`/`template` now have first-class faces, but advanced dialog lifecycle helpers are still manual
  - Pointer/drag semantics are event-helper based, not full platform model parity
- Gaps:
  - No first-class Web Components/Shadow DOM/custom element DSL surface

### Vista Graphics (Canvas aligned)
- Strong coverage:
  - 2D context bootstrap and draw pipeline
  - Stroke/fill, path primitives, transforms, gradients, text/image draw
  - Canvas integration through native `canvas` face + draw block workflow
- Partial coverage:
  - Some shape/curve compatibility paths are approximated
  - `clip` and `gamma` semantics are constrained by Canvas limitations
  - Smoothing controls map to `imageSmoothingEnabled` only
- Gaps:
  - No first-class SVG rendering dialect target
  - No WebGL/WebGPU DSL or runtime abstraction in Vista Graphics

## Priority gap list (recommended)

1. Define a Web Components extension layer (custom element registration and shadow root hooks).
2. Expand pointer/touch API coverage into an explicit high-level Vista abstraction (not only mapped DOM events).
3. Add dialog lifecycle helpers (`showModal`, close reasons, focus trap defaults) as first-class runtime utilities.
4. Extend graphics backend options (SVG output target and/or WebGL/WebGPU-oriented drawing mode).

## Confidence

- High confidence for the quantified counts and tracker status because they come directly from repo matrices/scripts.
- Medium confidence for spec-area mapping because it is intentionally grouped into major feature areas rather than every normative clause in the Living Standard.
