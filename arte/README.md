# Arte

Arte is a full-stack app builder for Arturo + Vista.

## Layout

- `ui/` - Vista-based builder UI and runtime preview
- `api/` - Arturo HTTP API, auth, orchestration
- `shared/` - contracts and schemas shared by UI/API
- `docs/` - architecture and protocol notes

## Run

1. Start API:
`arturo arte/api/server.art`
2. Start UI:
`arturo arte/ui/app.art`

Defaults:
- API port: `19010` (override with `ARTE_API_PORT`)
- DB: Grafito via `arte/api/db/grafito.art`

## Current Features

- Auth: signup/login/logout/session token, `me` endpoint with workspace info
- Workspace: members list/add, role-gated admin actions
- Invites: create/list/accept/revoke, cleanup expired invites
- Apps/Pages: CRUD for apps and pages
- Layout: JSON component model persisted per page
- Preview/Export: Vista HTML preview and `.art` export
- Vista Graphics-aware layout nodes:
  - `canvas`, `box`, `col`, `image`, `divider`, `raw_vista`
