# Lucide Icons

This folder contains Lucide icons for the Vista UI framework.

## Installation

Download icons from https://lucide.dev/icons/ or use npm:

```bash
npm install lucide
cp node_modules/lucide/icons/*.svg .
```

## Recommended Icons

Start with these commonly-needed icons:
- `home.svg` - Navigation
- `settings.svg` - Configuration
- `user.svg` - User profile
- `search.svg` - Search
- `menu.svg` - Mobile menu
- `x.svg` - Close/dismiss
- `chevron-down.svg` - Dropdowns
- `chevron-right.svg` - Navigation
- `plus.svg` - Add/create
- `minus.svg` - Remove
- `edit.svg` - Edit
- `trash.svg` - Delete
- `check.svg` - Success/confirm
- `alert-circle.svg` - Warnings

## Usage in Vista

```arturo
; Using icon_theme function
icon_theme "home" "default" 24

; Using icon style
icon "home.svg"
```

## Configuration

The icon path is configured in `src/vista/core/enhancements.art`:

```arturo
icons: #[
    path: "resources/icons/lucide/"
    ext: ".svg"
]
```
