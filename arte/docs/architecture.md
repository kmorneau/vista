# Architecture

## Goals

- Strict separation: UI <-> API <-> Grafito
- UI never imports DB adapters
- API owns persistence and business logic

## Boundaries

- `arte/ui`: visual builder + runtime preview
- `arte/api`: REST-like JSON API + auth + orchestration
- `arte/shared`: contracts/schemas shared as static artifacts

## Data Flow

UI -> HTTP -> API -> repositories -> Grafito

## Runtime Notes

- UI imports workspace `vista.art`, which delegates to `src/vista/vista.art`.
- This keeps Arte aligned with latest Vista core and Vista Graphics modules.
- Layout compiler in UI/API supports both basic UI nodes and graphics-ready nodes.

## Layout Node Types

- Basic: `title`, `text`, `button`, `input`, `row`
- Containers: `box`, `col`
- Graphics/media: `canvas`, `image`, `divider`
- Escape hatch: `raw_vista` for direct Vista snippet injection

## Access Model

- Workspace-scoped isolation using `workspace_id`
- Session token required for tokened API routes
- Roles: `admin`, `builder`, `viewer`
- Admin-only operations:
  - workspace members management
  - workspace invites management
