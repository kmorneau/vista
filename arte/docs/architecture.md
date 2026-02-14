# Architecture (Draft)

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

## Notes

- All POST/PUT endpoints will accept JSON bodies.
- Responses will use `{ ok, data, error, meta }` envelopes.
