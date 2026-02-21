# API Contract

## Conventions

- JSON request bodies for POST/PUT
- Response envelope:
  - success: `{ ok: true, data }`
  - error: `{ ok: false, error: { code, message, details } }`
- Error shape: `{ code, message, details }`

## Core Routes (v0)

- `GET /api/health`
- `POST /api/auth/signup`
- `POST /api/auth/login`
- `POST /api/auth/logout`
- `GET /api/auth/me/:token`
- `GET /api/apps/:token`
- `POST /api/apps/:token`
- `PUT /api/apps/:token/:id`
- `DELETE /api/apps/:token/:id`
- `GET /api/apps/:token/:id/pages`
- `POST /api/apps/:token/:id/pages`
- `GET /api/apps/:token/:id/members`
- `POST /api/apps/:token/:id/members`
- `GET /api/pages/:token/:id`
- `PUT /api/pages/:token/:id`
- `DELETE /api/pages/:token/:id`
- `GET /api/pages/:token/:id/components`
- `PUT /api/pages/:token/:id/components`
- `POST /api/pages/:token/:id/preview`
- `POST /api/pages/:token/:id/export`
- `GET /api/workspaces/:token/members`
- `POST /api/workspaces/:token/members`
- `GET /api/workspaces/:token/invites`
- `POST /api/workspaces/:token/invites`
- `DELETE /api/workspaces/:token/invites/:code`
- `POST /api/workspaces/:token/invites/cleanup`
- `POST /api/invites/accept`
