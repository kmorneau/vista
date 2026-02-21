---
title: Getting Started
layout: docpage
category: Getting Started
tags: ["quickstart", "tutorial", "basics"]
---

# Getting Started

This wiki is a practical reference for the Vista UI layer.

## Quick Start
`
import "vista.art"!

view [
text "Hello"
button "OK" [print "ok"]
]
`

## Auth Flow Quick Start
For a managed auth flow (intro splash -> login/signup -> account), use `auth_app`.

Required state includes:
- `show_intro_splash`
- `show_splash`
- `show_login`
- `show_signup`
- `show_account`

Recommended startup:
`
show_intro_splash: true
show_splash: false
show_login: false
show_signup: false
show_account: false
`

The intro splash auto-transitions after 5 seconds via `.rate:5000` and `.on-tick`.

## Build the Docs
`
arturo tools/build.art
`

## See Also

- [VID Overview](/wiki/core/concepts/vid-overview/) - Learn about the VID dialect
- [Migration](/wiki/shared/migration/) - REBOL/View and VID migration guides
- [Authentication](/docs/authentication/) - Auth helpers and `auth_app`
