# Data Model

## Grafito Collections

- `workspace`
- `workspace_member`
- `workspace_invite`
- `auth_user`
- `auth_session`
- `app`
- `page`
- `component`
- `app_member`

## Key Fields

- `auth_user`: `user_id`, `email`, `password_hash`, `password_salt`, `password_iters`, `role`, `workspace_id`
- `auth_session`: `session_id`, `user_id`, `token_hash`, `created_at`
- `workspace_invite`: `workspace_id`, `email`, `role`, `code`, `expires_at`, `used`, `used_at`
- `app`: `id`, `workspace_id`, `name`, `slug`, timestamps
- `page`: `id`, `app_id`, `name`, `slug`, timestamps
- `component`: `page_id`, ordered list payload (JSON-compatible blocks)
