# Vista UI Framework - Test Coverage Report

## Coverage Summary

This project uses snapshot tests.

- Snapshot generator input list: `tests/run_tests.art`
- Snapshot output: `tests/snapshots/snapshots/*.html`
- Snapshot manifest: `tests/snapshots/manifest.json`
- Current snapshot suite size: `57` scripts (explicit file list in `tests/run_tests.art`)
- Rebol/View/VID feature matrix: `docs/coverage/rebol_view_vid_coverage.csv`
- Rebol Draw feature matrix: `docs/coverage/rebol_draw_coverage.csv`

The two CSVs are the authoritative feature-coverage trackers for parity work.

## Key Snapshot Areas

- Layout words and containers (`across`, `below`, `return`, `grid`, `panel`, `split`)
- Widget coverage (`field`, `radio`, `list`, `tabs`, `table`, `toolbar`, `menubar`, `canvas`)
- Event mapping (`on-click`, `on-change`, `on-input`, `on-over`, `on-out`, `on-down`, `on-up`)
- Runtime helpers and registry tooling (`face-tree`, overlay inspector, named face lookup)
- App header rendering (`tests/47-app-header.art`)
- Draw/graphics (`tests/49-draw-primitives.art` through `tests/54-draw-arc-curve-flood.art`)
- VID mode and style/facet mapping (`tests/26-vid-phase1.art`, `tests/28-vid-mode.art`, `tests/39-edge-facets.art`)

## Test Commands

```bash
# Run all snapshot tests
NO_WEBVIEW=1 arturo tests/run_tests.art

# Check for regressions
arturo tests/check_snapshots.art

```

## Running Tests

All tests should pass. If tests fail:
1. Check that Arturo is installed
2. Run snapshot generation with `NO_WEBVIEW=1` for headless testing
