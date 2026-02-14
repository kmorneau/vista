# Authentication

Vista includes:

- API auth module (Arturo) with signup, login, session tokens, MFA (OTP), role-based permissions, and account management.
- UI helpers for splash screens, login/signup forms, and account tools.

## API Overview

All endpoints use **path parameters** in this scaffold.

### Endpoints

- `POST /api/auth/signup/:email/:password`
- `POST /api/auth/login/:email/:password`
- `POST /api/auth/mfa/verify/:challenge/:code`
- `POST /api/auth/logout/:token`
- `GET /api/auth/me/:token`
- `PUT /api/auth/password/:token/:old/:new`
- `PUT /api/auth/email/:token/:email`
- `PUT /api/auth/role/:token/:userId/:role` (admin only)
- `POST /api/auth/mfa/enable/:token`
- `POST /api/auth/mfa/disable/:token`
- `GET /api/auth/users/:token` (admin only)
- `DELETE /api/auth/account/:token`

### Roles

Default roles:

- `admin`
- `user`

Role changes require an admin token via `/api/auth/role`.

### MFA (OTP)

1. If MFA is enabled for a user, `/api/auth/login` returns:
   - `mfa_required: true`
   - `challenge_id`
   - `mfa_code` (development convenience so the client can deliver it)
2. Verify with `/api/auth/mfa/verify/:challenge/:code` to receive the session token.

### Password Hashing

Passwords are hashed with a salted, iterated SHA1 using Arturo’s built-in Crypto module. This is a **starter** implementation. For production, swap in a real bcrypt/argon2 implementation.

## UI Helpers (Vista)

Vista provides style helpers:

- `auth_splash`
- `auth_login`
- `auth_signup`
- `auth_account`

Hyphenated aliases exist for docs readability:

- `auth-splash`
- `auth-login`
- `auth-signup`
- `auth-account`

### Splash Screen

```arturo
import "vista.art"!

view [
    auth_splash "Welcome" "Sign in to continue"
]
```

### Login + Signup

```arturo
import "vista.art"!

email: ""
password: ""
code: ""

view [
    auth_login email password code [
        print ["Login" email password code]
    ]
    divider
    auth_signup email password [
        print ["Signup" email password]
    ]
]
```

### Account Tools

```arturo
import "vista.art"!

profileLabel: "Signed in as you@example.com"
newEmail: ""
oldPass: ""
newPass: ""

view [
    auth_account profileLabel newEmail [
        print ["Update email" newEmail]
    ] oldPass newPass [
        print ["Update password" oldPass newPass]
    ] [
        print "Enable MFA"
    ] [
        print "Disable MFA"
    ] [
        print "Sign out"
    ]
]
```

## Notes

- This scaffold uses URL params for credentials (not secure). For production, switch to JSON request bodies and HTTPS.
- MFA delivery (email/SMS) is not implemented; the API currently returns the OTP for client delivery.
