# API Contract

## Conventions

- JSON request/response
- Success envelope: `{ ok: true, data }`
- Error envelope: `{ ok: false, error: { code, message, details } }`

## Endpoints (Fill In)

- `GET /api/<app>/health`
- `GET /api/<app>/...`
- `POST /api/<app>/...`
- `PUT /api/<app>/...`
- `DELETE /api/<app>/...`

## Auth

- Define token/session requirements per endpoint.
- Document role-based access where needed.
