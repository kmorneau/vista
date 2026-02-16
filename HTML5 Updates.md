HTML5 Updates

Phase 1: HTML5 Faces + Accessibility (1-2 weeks)

Add first-class faces: dialog, details, summary, template.
Files: 01-faces.art, 03-styles-aliases.art
Deliverables: face constructors, facet mapping, ARIA defaults, keyboard handlers.
Tests: add snapshot + behavior tests in /Users/kmorneau/Documents/GitHub/vista/tests.
Strengthen semantic text/headings.
Files: 01-faces.art
Deliverables: better h1-h6/p mapping options from title/subtitle/text/label.

Phase 2: Interaction + Media Parity (1-2 weeks)

Pointer/touch abstraction layer.
Files: 05-view-entry.art, 03-styles-aliases.art
Deliverables: on-pointer-down/move/up/cancel, tap/long-press helpers.
Native DnD support.
Files: 03-styles-aliases.art
Deliverables: dragstart/dragover/drop events with dataTransfer payload support.
Media enhancements.
Files: 01-faces.art
Deliverables: multi-source, track, preload/autoplay/muted/poster controls.

Phase 3: Graphics Backend Expansion (2-3 weeks)

Add SVG output backend for draw dialect.
Files: drawing.art (or split new backend file)
Deliverables: Canvas remains default, SVG optional target for export/print/static.
Improve clipping/curve parity docs + behavior.
Files: drawing.art, html5_vista_coverage_matrix.md
Deliverables: explicit parity levels for clip, spline, gamma.

Phase 4: Compiler Architecture Hardening (2 weeks) ✅ COMPLETE

Introduce typed IR.
Files: src/vista/compiler/ir.art, src/vista/compiler/parser.art, src/vista/compiler/emitter.art
Deliverables: parse DSL -> IR -> emit HTML/CSS/JS. ✅ DONE
  - IR types defined: IR_NODE_FACE, IR_NODE_TEXT, IR_NODE_LAYOUT, IR_NODE_EVENT, etc.
  - Parser converts layout DSL to typed IR document
  - Emitter generates HTML from IR nodes
  - Backward compatibility maintained via compile_direct fallback

Replace dynamic-eval-heavy paths with structured handlers.
Files: src/vista/compiler/dispatch.art
Deliverables: event opcodes/dispatch table, reduced inline JS generation risk. ✅ DONE
  - Dispatch table with validated operations: set, toggle, increment, navigate, alert, etc.
  - JS validation to block dangerous patterns (eval, Function, document.write, etc.)
  - Legacy compatibility layer for gradual migration

Compile-time diagnostics.
Files: src/vista/compiler/ir.art (diagnostic system)
Deliverables: warnings/errors for unknown faces/facets/events, invalid combinations. ✅ DONE
  - ir_validate_face_type(), ir_validate_layout_directive(), ir_validate_event_type()
  - Diagnostic levels: IR_DIAG_ERROR, IR_DIAG_WARNING, IR_DIAG_INFO, IR_DIAG_HINT
  - ir_add_diagnostic() collects issues during parsing
  - ir_has_errors() for fail-fast compilation

Phase 5: Performance + Developer UX (1-2 weeks) ✅ COMPLETE

Incremental compilation/caching.
Files: src/vista/compiler/cache.art
Deliverables: hash-based cache for unchanged subtrees. ✅ DONE
  - cache_compute_hash() for block hashing
  - cache_get(), cache_set() for cache operations
  - cache_invalidate(), cache_clear() for cache management

Deterministic output mode.
Files: src/vista/compiler/deterministic.art
Deliverables: stable attribute/key ordering to reduce snapshot churn. ✅ DONE
  - deterministic_sort_attributes() for stable attribute ordering
  - deterministic_normalize_keys() for consistent key sorting
  - deterministic_order_face() for face property ordering

Source mapping for generated output.
Files: src/vista/compiler/sourcemap.art
Deliverables: map generated nodes back to .art line references. ✅ DONE
  - sourcemap_init() for source map creation
  - sourcemap_add_mapping() for line/column mappings
  - sourcemap_emit() for JSON output generation

Phase 6: CI and Coverage Gates (1 week) ✅ COMPLETE

Feature coverage validation.
Files: scripts/check_feature_coverage.art
Deliverables: fail on regression of Full/Partial/Gap thresholds. ✅ DONE
  - Threshold checks: max 5 gaps, min 30 full
  - JSON report generation for visibility
  - Supports custom thresholds via configuration
  - Can be run locally or integrated into existing CI

Add dedicated "spec parity" test group.
Files: tests/run_spec_parity.art
Deliverables: one test per mapped spec area with expected behavior. ✅ DONE
  - Test runner for html5-core, graphics, vid-parity categories
  - JSON result output for integration
  - Coverage threshold validation
