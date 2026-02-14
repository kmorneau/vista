# API Contract (Draft)

## Conventions

- JSON request bodies for POST/PUT
- Response envelope: `{ ok, data, error, meta }`
- Error shape: `{ code, message, details }`

## Core Routes (v0)

- `GET /api/health`
- `POST /api/auth/signup`
- `POST /api/auth/login`
- `GET /api/apps`
- `POST /api/apps`
- `GET /api/apps/:id`
- `PUT /api/apps/:id`
- `DELETE /api/apps/:id`
