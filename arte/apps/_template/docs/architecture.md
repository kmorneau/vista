# Architecture

## Goals

- Strict separation: UI <-> API <-> persistence
- Clear app boundary inside `arte/apps/<app-slug>/`
- Reusable shared contracts

## Boundaries

- `ui/`: screens, workflows, view composition
- `api/`: endpoints, validation, business rules
- `shared/`: request/response shapes, enums, schema docs

## Data Flow

UI -> HTTP -> API -> repositories/storage

## Notes

- Keep this app isolated from other app folders.
- Avoid importing app-specific logic across sibling apps.
