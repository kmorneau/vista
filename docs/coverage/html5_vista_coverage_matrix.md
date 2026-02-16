# HTML5 + Graphics Coverage Matrix for Vista

This matrix maps major HTML5/graphics spec areas to Vista/Vista-graphics implementation status.

Status legend:
- `Full`: Implemented and directly mapped in current Vista APIs.
- `Partial`: Implemented with limitations or semantic differences.
- `Gap`: No first-class Vista API abstraction today.

## HTML5 Core

| Spec Area | Spec Anchor | Vista Mapping | Status | Evidence | Notes |
|---|---|---|---|---|---|
| Document skeleton | WHATWG HTML: document structure | `build_full_html` emits `<!DOCTYPE html>`, `<html>`, `<head>`, `<body>` | Full | `src/vista/modules/04-layout-core.art:2274` | Core shell generated consistently. |
| Metadata | WHATWG HTML: metadata content | `meta charset` + `meta viewport` emitted | Full | `src/vista/modules/04-layout-core.art:2274` | Baseline responsive/meta support present. |
| Sectioning/content containers | WHATWG HTML: flow content | `box`, `panel`, `row`, `col`, `group`, `grid`, `split` | Full | `src/vista/modules/01-faces.art` | Implemented via `<div>`/grid/flex patterns. |
| Headings/text | WHATWG HTML: text-level semantics | `title`, `subtitle`, `text`, `label` | Partial | `src/vista/modules/01-faces.art:62` | Semantic heading tags used for title/subtitle; most text is `span`/`label` wrappers. |
| Lists | WHATWG HTML: list elements | `list`, `text-list` -> `<ul><li>` | Full | `src/vista/modules/01-faces.art:239` | Includes bound and static list rendering. |
| Tables | WHATWG HTML: table model | `table`, `table-row`, `table-cell`, `table-head/body/foot`, `table-header` | Full | `src/vista/modules/01-faces.art:123` | Full table tag surface is present. |
| Images | WHATWG HTML: embedded content | `image`, `icon`, `anim` aliases | Partial | `src/vista/modules/01-faces.art:573`, `docs/coverage/rebol_view_vid_coverage.csv` | `icon` and `anim` are compatibility aliases without native icon-pack/timeline semantics. |
| Forms | WHATWG HTML: forms | `form`, `field`, `input`, `textarea`, `select`, `radio`, `checkbox`, `toggle`, `progress` | Full | `src/vista/modules/01-faces.art:360` | Rich form surface exists with bindings and event hooks. |
| Generic attribute model | WHATWG HTML: global attributes | Attribute parsing/passthrough (`attrs_to_html`) | Full | `src/vista/modules/03-styles-aliases.art:885` | Enables custom attrs like `aria-*`/`role` manually. |
| Native media elements | WHATWG HTML: media elements | First-class `audio` and `video` faces (literal or bound `src`) | Partial | `src/vista/modules/01-faces.art`, `src/vista/modules/04-layout-core.art` | Covers element rendering and bound `src` updates; advanced track/source-set abstractions are still manual. |
| Native interactive elements | WHATWG HTML: interactive elements | First-class `dialog`, `details`, `summary`, `template` faces | Partial | `src/vista/modules/01-faces.art`; `src/vista/modules/04-layout-core.art` | Core element mapping exists; advanced lifecycle helpers (`showModal`, focus trap patterns) are still app-level/manual. |
| Drag and drop API | WHATWG HTML: DnD | Mouse-drag helper via `feel` (`data-feel-drag`) | Partial | `src/vista/modules/03-styles-aliases.art:1805` | Not native HTML DnD event/dataTransfer model. |
| Pointer/touch input | WHATWG + Pointer Events | Mouse events mapped (`onmousedown`, `onmousemove`, etc.) | Partial | `src/vista/modules/05-view-entry.art:135` | No first-class pointer/touch abstraction layer. |
| Web Components | Custom elements/shadow DOM | No custom element/shadow APIs | Gap | `src/vista/modules` | Not represented in Vista face DSL. |

## Graphics (Canvas/SVG/WebGL Scope)

| Spec Area | Spec Anchor | Vista-graphics Mapping | Status | Evidence | Notes |
|---|---|---|---|---|---|
| Canvas 2D context bootstrap | WHATWG Canvas / 2D Context | `draw_to_canvas` gets `canvas.getContext('2d')` | Full | `src/vista/graphics/drawing.art:45` | Core rendering pipeline is in place. |
| Stroke/fill state | Canvas 2D | `pen`, `fill-pen`, `line-width`, `line-cap`, `line-join`, `line-pattern` | Full | `src/vista/graphics/drawing.art:57` | Good parity for basic paint state. |
| Basic shapes | Canvas 2D path drawing | `line`, `box`, `circle`, `ellipse`, `polygon`, `triangle`, `arc` | Full | `src/vista/graphics/drawing.art:273` | Includes standard primitives and arc support. |
| Curves | Canvas 2D curves | `curve` (quadratic/cubic), `spline` | Partial | `src/vista/graphics/drawing.art:429` | Parity: `curve` full; `spline` partial (midpoint quadratic approximation, no tension controls). |
| Text drawing | Canvas 2D text | `text`, `font`, `text-align`, `text-baseline` | Full | `src/vista/graphics/drawing.art:117` | Uses `fillText` and text state settings. |
| Image drawing | Canvas 2D images | `image` draw op with optional size | Full | `src/vista/graphics/drawing.art:499` | Supports async load plus canvas-level preload orchestration (`draw_script_preload`). |
| Transform stack | Canvas 2D transforms | `push/pop`, `translate/rotate/scale/skew`, `matrix/transform/reset/invert` | Full | `src/vista/graphics/drawing.art:174` | Broad transform support is implemented. |
| Clip | Canvas 2D clipping region | `clip` command | Partial | `src/vista/graphics/drawing.art:258` | Parity: rectangle/polygon/path clipping supported; no nested clip stack management API. |
| Fill rule | Canvas 2D fill algorithm | `fill-rule` internal state (`ctx.__vistaFillRule`) | Full | `src/vista/graphics/drawing.art:157` | Applied in filled path operations. |
| Gradients | Canvas 2D gradients | `linear-gradient`, `radial-gradient`, `grad-pen` | Full | `src/vista/graphics/drawing.art:526` | Stop lists mapped to `addColorStop`. |
| Anti-alias controls | Canvas behavior | `smooth`, `anti-alias` -> `imageSmoothingEnabled` | Partial | `src/vista/graphics/drawing.art:141` | Affects image smoothing; not true geometric AA control. |
| Gamma | Draw compatibility vs Canvas limits | `gamma` accepted | Partial | `src/vista/graphics/drawing.art:165` | Parity: accepted syntax only; no direct Canvas/SVG gamma transform (no-op). |
| Coordinate system modes | Draw compatibility feature | `coord-system` supports `vid`, `math`, `center`, `center-math` | Full | `src/vista/graphics/drawing.art:219` | Supports optional custom origin point. |
| Shape sub-dialect | Draw shape grammar | `shape` as Path2D string or point block | Partial | `src/vista/graphics/drawing.art:399` | Not full REBOL shape sub-dialect parity. |
| Canvas integration in Vista UI | HTML canvas element usage | `canvas` face + script injection | Full | `src/vista/modules/01-faces.art:188`, `src/vista/modules/04-layout-core.art:2296` | Draw blocks render automatically for canvas faces with `id`. |
| SVG 2 rendering model | SVG 2 | Optional draw export backend (`draw_to_svg`, `draw_svg`) | Partial | `src/vista/graphics/drawing.art` | Canvas remains default; SVG export supports static/print output for core primitives. |
| WebGL context/model | WebGL | No WebGL dialect/runtime mapping | Gap | `src/vista/modules`, `src/vista/graphics` | No `webgl` canvas context path in draw engine. |

## Tracker Cross-check (Current Repo Metrics)

- REBOL Draw tracker: `39 full`, `3 partial`, `0 none` in `docs/coverage/rebol_draw_coverage.csv`.
- REBOL View/VID tracker: `50 full`, `5 partial`, `0 none` in `docs/coverage/rebol_view_vid_coverage.csv`.

Partial items called out by trackers:
- Draw: `shape_sub_dialect`, `clip`, `gamma`, `spline`.
- VID: `tabs_keyword`, `tab_keyword`, `backcolor`, `icon`, `anim`.
