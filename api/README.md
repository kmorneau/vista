# Vista API Scaffold (Arturo)

This is a layered REST-style starter implementation:

- `api/server.art` - HTTP entrypoint and route map
- `api/routes/users.art` - route handlers (HTTP concerns only)
- `api/routes/ai_chat.art` - provider-agnostic AI chat routes
- `api/services/users_service.art` - business logic and orchestration
- `api/services/ai_chat_service.art` - AI orchestration and validation
- `api/repositories/users_repo.art` - Grafito-backed persistence adapter
- `api/db/grafito.art` - shared Grafito DB bootstrap/wrapper
- `api/http/responses.art` - JSON response envelopes
- `api/http/validation.art` - input validation helpers
- `api/providers/ai_providers.art` - provider adapters (openai, gemini, kilo, echo)

## Run

```bash
arturo api/server.art
```

Optional port override:

```bash
API_PORT=19000 arturo api/server.art
```

## Endpoints (v1 scaffold)

- `GET /api/health`
- `GET /api/users`
- `GET /api/users/:id`
- `POST /api/users/:name/:email`
- `PUT /api/users/:id/:name/:email`
- `DELETE /api/users/:id`
- `GET /api/ai/providers`
- `POST /api/ai/chat/:provider/:model/:temperature/:prompt`

## Notes

- This starter intentionally uses path params for create/update to stay minimal.
- Persistence uses Grafito (`vista_api.graf` in the project root).
- AI providers:
  - `openai` uses `OPENAI_API_KEY` (+ optional `AI_OPENAI_URL`)
  - `gemini` uses `GEMINI_API_KEY` (+ optional `AI_GEMINI_URL`)
  - `kilo` uses `KILO_API_KEY` + `AI_KILO_URL`
  - `echo` is local test provider (no external API key)
- Next step for production: parse JSON request bodies for `POST`/`PUT`/`PATCH` and add auth + tests.
