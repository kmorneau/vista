# Arte Apps Guide

Each Arte app starts in its own folder under `arte/apps/`.

## App Folder Rule

- One app = one folder: `arte/apps/<app-slug>/`
- Keep the same separation used in `arte/docs`:
  - `ui/` for Vista UI
  - `api/` for app API/business logic
  - `shared/` for contracts/schemas
  - `docs/` for architecture + API + data model

## Recommended App Scaffold

```text
arte/apps/<app-slug>/
  ui/
  api/
  shared/
  docs/
    architecture.md
    api-contract.md
    data-model.md
```

## Create A New App Folder

Primary flow (from Arte UI):

1. Sign in to Arte.
2. Go to `Apps`.
3. Create an app name.
4. Arte API will auto-create `arte/apps/<app-slug>/` from template, including:
   - `ui/app.art` with splash + auth + AI chat + settings
   - `ui/arte-logo.png` (default logo)
   - `db/grafito.graf` (default Grafito DB)
   - `docs/` starter docs
   - `api/` and `shared/` folders
5. Optional: provide `data_model` during app creation to prefill:
   - `docs/data-model.md`
   - `db/data-model.md`

Manual flow (optional):

1. Pick a slug (example: `crm-studio`).
2. Copy `arte/apps/_template/` to `arte/apps/crm-studio/`.
3. Update docs in `arte/apps/crm-studio/docs/`.
4. Implement UI/API/shared in that folder.

Use `arte/docs` as the baseline reference, then specialize per app.
