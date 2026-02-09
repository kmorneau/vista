---
title: Responsive Design
layout: docpage
category: Styles
tags: ["styles", "responsive", "media-queries", "mobile"]
---

# Responsive Design

Vista provides responsive utilities and breakpoints.

## Breakpoints
/* Small devices (landscape phones, 576px and up) */
--bp-sm: 576px;

/* Medium devices (tablets, 768px and up) */
--bp-md: 768px;

/* Large devices (desktops, 992px and up) */
--bp-lg: 992px;

/* Extra large devices (large desktops, 1200px and up) */
--bp-xl: 1200px;

## Media Query Mixins
/* Mobile-first approach */
.my-component {
  width: 100%;
}

@media (min-width: 768px) {
  .my-component {
width: 50%;
  }
}

@media (min-width: 992px) {
  .my-component {
width: 33.33%;
  }
}

## Responsive Classes

- **.visible-sm**, **.hidden-sm**: Show/hide on small

- **.visible-md**, **.hidden-md**: Show/hide on medium

- **.visible-lg**, **.hidden-lg**: Show/hide on large

## Fluid Typography
.responsive-text {
  font-size: clamp(14px, 4vw, 24px);
}

## Flex Responsive
.responsive-flex {
  display: flex;
  flex-direction: column;
}

@media (min-width: 768px) {
  .responsive-flex {
flex-direction: row;
  }
}

## Grid Responsive
.responsive-grid {
  display: grid;
  grid-template-columns: 1fr;
  gap: 16px;
}

@media (min-width: 576px) {
  .responsive-grid {
grid-template-columns: repeat(2, 1fr);
  }
}

@media (min-width: 992px) {
  .responsive-grid {
grid-template-columns: repeat(4, 1fr);
  }
}

## Best Practices

- Use mobile-first CSS (min-width queries)

- Test on actual devices

- Use relative units (rem, em, %)

- Consider touch targets (minimum 44x44px)

## See Also

- [CSS Classes](/wiki/shared/styles/css-classes/) - Available styling classes

- [Theme Variables](/wiki/shared/styles/theme-variables/) - Theme customization
