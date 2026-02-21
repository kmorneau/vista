# App Template

Copy this folder to create a new Arte app workspace:

- source: `arte/apps/_template/`
- target: `arte/apps/<your-app-slug>/`

Then replace placeholder text in:

- `docs/architecture.md`
- `docs/api-contract.md`
- `docs/data-model.md`
- `ui/app.art`

Default template includes:

- Intro splash screen
- Authentication (`auth_app` sign in/sign up/sign out)
- AI chat screen
- AI settings screen
- Default logo file: `ui/arte-logo.png`
- Default Grafito DB file: `db/grafito.graf`
- Vendored runtime + package dependencies:
- `ui/vista.art` + `ui/src/vista/` (includes `graphics/`)
- `ui/dist/assets/icons/` (icons used by auth/UI components)
- `vendor/grafito/`
