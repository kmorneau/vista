# Vista (Rebol/View-style UI for Arturo)

Vista provides a Rebol/View-inspired UI layer for Arturo, rendered to HTML/WebView.

## Architecture

Vista now uses a modular implementation:

- Public entrypoint: `vista.art` (root wrapper)
- Canonical entrypoint: `src/vista/vista.art`
- Core modules: `src/vista/modules/*.art`
- Graphics modules: `src/vista/graphics/*.art`

## Quick Start

```arturo
import "vista.art"!

view [
    text "Hello"
    button "OK" [print "ok"]
]
```

### Local development

Use the local file import when working in this repo without installing the package:

```arturo
import "vista.art"!
```

## Run an App (Header)

Use the `ARTURO [...]` header and `run_app` helper:

```arturo
import "vista.art"!

ARTURO [
    Title: "ARTURO/VISTA"
    Logo: "arturo-vista.png"
    Width: 320
    Height: 140
]

run_app [
    text "Hello"
]
```

The `Logo` field controls the ARTURO header logo. If omitted, the default
is `arturo-vista.png` in the project root. You can also pass a data URL
to embed the image directly.

### HTML Output Header

`view` always generates the same application header used by the examples:

- `ARTURO/VISTA` brand mark
- Optional app title (from `ARTURO [Title: ...]`, hidden when equal to `ARTURO/VISTA`)
- Logo image (from `ARTURO [Logo: ...]`, default `arturo-vista.png`)

## Tests

Generate snapshots:

```sh
arturo tests/run_tests.art
```

Verify snapshots:

```sh
arturo tests/check_snapshots.art
```

Behavior smoke tests (requires `jsdom`):

```sh
npm install --save-dev jsdom
tests/run_behavior.sh
```

## Docs

- `vista_tutorial.md`
- `VID_COMPAT.md`
- `VID_PARITY.md`
- `RELEASE_NOTES.md`
- `TEST_COVERAGE.md`
- `docs/coverage/rebol_view_vid_coverage.csv`
- `docs/coverage/rebol_draw_coverage.csv`
- `ARTURO_GUIDE.md`
- `data/wiki/` (WIP wiki markdown sources)

See `vista_tutorial.md` for the Rebol/View translation guide and state/event best practices.

## Auth Helpers

Vista ships UI helpers for auth flows (splash, login/signup forms, account tools). Usage:

```arturo
import "vista.art"!

email: ""
password: ""
code: ""

view [
    auth_splash "Welcome" "Sign in to continue"
    auth_login email password code [
        print ["Login with" email password code]
    ]
]
```

## Draw (HTML5 Canvas)

Vista includes a Rebol/View Draw-style helper module in `src/vista/graphics/vista-graphics.art`. The `canvas` face accepts a Draw block as its first argument and renders it to HTML5 Canvas at runtime.

```arturo
import "vista.art"!

view [
    canvas .id:"demo" .width: 240 .height: 140 [
        pen "#1f5cff"
        line-width 3
        line [20 20] [200 20]
        fill-pen "#f0f4ff"
        box [20 40] [200 120]
    ]
]
```

Limitations: this is a client-side Canvas renderer; text metrics and image loading behave like standard HTML5 Canvas.

## Examples

The `examples/` directory contains runnable demos. For example:

```sh
arturo examples/01-hello-world.art
```
