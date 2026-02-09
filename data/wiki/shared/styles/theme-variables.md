---
title: Theme Variables
layout: docpage
category: Styles
tags: ["styles", "theme", "variables", "customization"]
---

# Theme Variables

Vista uses CSS custom properties (variables) for theming.

## Color Variables
:root {
  --primary-color: #3498db;
  --secondary-color: #2ecc71;
  --accent-color: #e74c3c;
  --background-color: #ffffff;
  --text-color: #333333;
  --border-color: #dddddd;
  --error-color: #e74c3c;
  --warning-color: #f39c12;
  --success-color: #2ecc71;
  --info-color: #3498db;
}

## Typography Variables
:root {
  --font-family: 'Segoe UI', sans-serif;
  --font-size-sm: 12px;
  --font-size-base: 14px;
  --font-size-lg: 16px;
  --font-size-xl: 20px;
  --font-size-2xl: 24px;
  --line-height: 1.5;
}

## Spacing Variables
:root {
  --spacing-xs: 4px;
  --spacing-sm: 8px;
  --spacing-md: 16px;
  --spacing-lg: 24px;
  --spacing-xl: 32px;
}

## Border Variables
:root {
  --border-radius: 4px;
  --border-width: 1px;
  --border-style: solid;
}

## Shadow Variables
:root {
  --shadow-sm: 0 1px 2px rgba(0,0,0,0.1);
  --shadow-md: 0 4px 6px rgba(0,0,0,0.1);
  --shadow-lg: 0 10px 15px rgba(0,0,0,0.1);
}

## Dark Mode
[data-theme="dark"] {
  --background-color: #1a1a1a;
  --text-color: #ffffff;
  --border-color: #333333;
}

## See Also

- [CSS Classes](/wiki/shared/styles/css-classes/) - Available styling classes

- [Responsive Design](/wiki/shared/styles/responsive-design/) - Responsive utilities
