# Vista API Scaffold (Arturo)

This is a layered REST-style starter implementation:

- `api/server.art` - HTTP entrypoint and route map
- `api/routes/users.art` - route handlers (HTTP concerns only)
- `api/routes/ai_chat.art` - provider-agnostic AI chat routes
- `api/routes/auth.art` - auth routes (signup/login/mfa/account)
- `api/services/users_service.art` - business logic and orchestration
- `api/services/auth_service.art` - auth orchestration and validation
- `api/services/ai_chat_service.art` - AI orchestration and validation
- `api/repositories/users_repo.art` - Grafito-backed persistence adapter
- `api/repositories/auth_repo.art` - Grafito-backed auth persistence adapter
- `api/db/grafito.art` - shared Grafito DB bootstrap/wrapper
- `api/http/responses.art` - JSON response envelopes
- `api/http/validation.art` - input validation helpers
- `api/security/security_core.art` - reusable security checks + middleware-style guard chain
- `api/providers/ai_providers.art` - provider adapters (openai, gemini, echo)

## Run

```bash
arturo api/server.art
```

Optional port override:

```bash
API_PORT=19000 arturo api/server.art
```

AI API smoke test:

```bash
bash api/smoke_ai.sh
```

Security smoke test:

```bash
arturo tests/security-smoke.art
```

v3 JSON body/header smoke test:

```bash
bash api/smoke_v3.sh
```

Arturo `serve.v2` adapter smoke test:

```bash
bash tests/serve-v2-smoke.sh
```

Optional live OpenAI check:

```bash
OPENAI_API_KEY=... bash api/smoke_ai.sh
```

## Endpoints (v1 scaffold)

- `GET /api/health`
- `GET /api/users`
- `GET /api/users/:id`
- `POST /api/users/:name/:email`
- `PUT /api/users/:id/:name/:email`
- `DELETE /api/users/:id`
- `POST /api/auth/signup/:email/:password`
- `POST /api/auth/login/:email/:password`
- `POST /api/auth/mfa/verify/:challenge/:code`
- `POST /api/auth/logout/:token`
- `GET /api/auth/me/:token`
- `PUT /api/auth/password/:token/:old/:new`
- `PUT /api/auth/email/:token/:email`
- `PUT /api/auth/role/:token/:userId/:role`
- `POST /api/auth/mfa/enable/:token`
- `POST /api/auth/mfa/disable/:token`
- `GET /api/auth/users/:token`
- `DELETE /api/auth/account/:token`
- `POST /api/auth/bootstrap/:secret/:email`
- `GET /api/v2/security/csrf/:clientId`
- `POST /api/v2/auth/signup/:clientId/:csrf/:payload`
- `POST /api/v2/auth/login/:clientId/:csrf/:payload`
- `POST /api/v2/auth/mfa/verify/:clientId/:csrf/:payload`
- `PUT /api/v2/auth/email/:clientId/:csrf/:payload`
- `PUT /api/v2/auth/password/:clientId/:csrf/:payload`
- `POST /api/v2/auth/logout/:clientId/:csrf/:payload`
- `GET /api/security/headers`
- `GET /api/security/audit/:token/:limit` (admin only)
- `POST /api/security/runtime/clear/:token` (admin only)
- `GET /api/ai/providers`
- `POST /api/ai/chat/:provider/:model/:temperature/:prompt`
- `POST /api/ai/chat/:provider/:model/:temperature/:topP/:maxTokens/:prompt`

## Notes

- This starter intentionally uses path params for create/update to stay minimal.
- Persistence uses Grafito (`vista_api.graf` in the project root).
- Auth uses salted, iterated SHA1 via the built-in Crypto module. For production, swap in a stronger KDF.
- Admin bootstrap:
  - `POST /api/auth/bootstrap/:secret/:email` promotes one user to `admin`.
  - Secret comes from `SECURITY_BOOTSTRAP_SECRET` (defaults to `vista-bootstrap-dev-secret` for local dev).
  - Bootstrap is single-seed: once an admin exists, promoting a different user via bootstrap returns conflict.
- v2 auth routes use URL-safe base64 JSON payload + CSRF token in the path as an interim pattern.
  - Reason: current `serve` handler API does not expose request body/headers directly.

## Security Core

- Import `api/security/security_core.art` in route modules.
- Use `sec_enforce @[ ...checks... ] [ ...handler... ]` to centralize auth/role/csrf/rate checks.
- Check helpers include:
  - `sec_check_required_token`
  - `sec_require_role`
  - `sec_check_origin`
  - `sec_check_csrf`
  - `sec_check_rate_limit`
- See `api/security/README.md` for integration pattern.
- Default rate-limit backend is Grafito (`sec_config\\rate_limit_backend: \"grafito\"`).
- Auth login lockout is enabled via `sec_check_lockout` + `sec_record_auth_failure/success`.

## MFA flow (OTP)

- `POST /api/auth/login/:email/:password` returns `mfa_required` when MFA is enabled.
- The response includes `challenge_id` and a development `mfa_code` (the client should deliver it out-of-band).
- Verify with `POST /api/auth/mfa/verify/:challenge/:code` to obtain a session token.
- AI providers:
  - `openai` uses `OPENAI_API_KEY` (+ optional `AI_OPENAI_URL`)
  - `gemini` uses `GEMINI_API_KEY` (+ optional `AI_GEMINI_URL`)
  - `echo` is local test provider (no external API key)
- Optional AI tuning route:
  - `POST /api/ai/chat/:provider/:model/:temperature/:topP/:maxTokens/:prompt`
  - Example: `/api/ai/chat/openai/gpt-4o-mini/0.7/0.9/256/Hello%20world`
- Next step for production: switch v2 payload routes to true JSON request body + header-based CSRF once server adapter exposes body/headers.

## v3 bridge (JSON body + headers)

`api/server_v3_bridge.js` provides header/body-native routes and forwards them to v2 Arturo handlers:

- `GET /api/v3/security/csrf/:clientId`
- `POST /api/v3/auth/signup`
- `POST /api/v3/auth/login`
- `POST /api/v3/auth/mfa/verify`
- `PUT /api/v3/auth/email`
- `PUT /api/v3/auth/password`
- `POST /api/v3/auth/logout`

Required headers on mutating v3 routes:

- `x-client-id`
- `x-csrf-token`

Run bridge:

```bash
API_BACKEND_BASE=http://localhost:18969 API_V3_PORT=18979 node api/server_v3_bridge.js
```

## Arturo serve.v2 adapter

Launch via Arturo:

```bash
API_BACKEND_BASE=http://localhost:18969 API_V3_PORT=19010 arturo api/serve_v2.art
```

Contract test endpoints exposed by the adapter:

- `GET /__servev2/health`
- `POST /__servev2/echo/:id`
