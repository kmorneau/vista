# Vista Arturo Package Proposal

## Goal
Package `vista.art` so users can install/import it as `import 'vista!` and keep the repository usable for local development.

## Proposed package structure
```
/ (repo root)
  vista.art           ; main package entry
  info.art            ; package metadata for pkgr
  lib/                ; internal modules (already present)
  examples/
  tests/
  tools/
  README.md
  ARTURO_GUIDE.md
  vista_tutorial.md
```

### Entry point
- Keep [`vista.art`](vista.art) as the package entry to preserve existing imports.
- Add `info.art` to configure the package (see below).

## Metadata (per pkgr.art)
- A package can be just a folder with a `main.art` file.
- For custom entry or metadata, include an `info.art` file.
- Supported fields in `info.art`:
  - `entry`: alternate entry file (if not using `main.art`).
  - `executable`: path to an executable file in the package.
  - `depends`: list of package dependencies.
  - `requires`: minimum Arturo version.

Example `info.art`:
```arturo
entry: "vista"       ; points to vista.art
requires: [>= 0.9.83]
depends: [
  ; [somePackage >= 0.0.2]
]
```

## Documentation updates
- Update docs to show:
  - `import 'vista!` for package usage.
  - (Optional) local development: `import "vista.art"!`

Files to update:
- [`README.md`](README.md:1)
- [`vista_tutorial.md`](vista_tutorial.md:1)
- [`data/wiki/getting-started.md`](data/wiki/getting-started.md:1)

## Distribution workflow
- Tag releases with SemVer.
- Publish to Arturo registry (or GitHub) using expected tooling.

## Risks/notes
- Confirm the official Arturo package manifest format and required fields.
- Ensure module exports are stable and documented.
