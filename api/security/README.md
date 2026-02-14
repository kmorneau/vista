# Security Core (Arturo)

`api/security/security_core.art` provides reusable checks and middleware-style chaining for API handlers.

## What it includes

- `sec_chain_checks checks` - evaluate checks and stop on first failure.
- `sec_enforce checks [ ... ]` - run checks, execute block on success, return HTTP error JSON on failure.
- `sec_check_required_token token fieldName`
- `sec_require_role user requiredRole`
- `sec_check_origin origin allowedOrigins`
- `sec_check_csrf method csrfHeader expectedToken`
- `sec_check_rate_limit bucket subject limit windowSecs`
- `sec_default_headers` - recommended response security headers map.
- `sec_audit_log eventType actor success details`
- `sec_get_audit_events_limited limit`
- `sec_issue_csrf_token subject`
- `sec_check_csrf_token subject token`
- `sec_check_lockout bucket subject`
- `sec_record_auth_failure bucket subject maxFailures windowSecs lockoutSecs`
- `sec_record_auth_success bucket subject`

## Handler usage pattern

```arturo
import "api/security/security_core.art"!

admin_users_handler: function [token origin csrfToken expectedCsrf user] [
    sec_enforce @[
        sec_check_required_token token "token"
        sec_check_origin origin sec_config\trusted_origins
        sec_check_csrf "GET" csrfToken expectedCsrf
        sec_require_role user "admin"
        sec_check_rate_limit "admin-users" token 30 60
    ] [
        ; protected logic
        ok #[items: []]
    ]
]
```

## Notes

- Rate limiting supports:
  - `sec_config\rate_limit_backend: "grafito"` (default, persistent/shared via `vista_api.graf`)
  - `sec_config\rate_limit_backend: "memory"` (process local)
- Audit backend supports:
  - `sec_config\audit_backend: "grafito"` (default, persistent)
  - `sec_config\audit_backend: "memory"` (process local)
- `sec_default_headers` returns a header map; attach it in your HTTP adapter layer.
- Keep route handlers thin: perform checks in `sec_enforce`, then call services.
- Current `serve` adapter does not expose request body/headers directly to handlers. v2 routes use URL-safe base64 JSON payload + CSRF path token as an interim secure pattern.
