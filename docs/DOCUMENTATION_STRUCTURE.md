# Vista Documentation Folder Structure Design

## Overview

This document defines the comprehensive folder structure for organizing Vista and Vista Graphics library documentation. The structure is designed to work with the existing `tools/build.art` system that scans `data/wiki/` for `.art` files and generates HTML documentation.

## Current System Analysis

### Build System Capabilities
- **Input**: `.art` files in `data/wiki/` directory
- **Metadata Format**: Arturo block comments `# [ "key": "value", ... #]`
- **Supported Metadata Fields**:
  - `title` (required): Page title displayed in navigation
  - `layout` (required): Template type (`docpage`, `page`)
  - `category` (optional): Section/category for sidebar organization
  - `tags` (optional): Array of tags for search/filtering
  - `body` (required): HTML content to render
- **Output**: HTML pages in `dist/wiki/<slug>/index.html`

### Key Observation
The build system scans recursively using `list.recursive WIKI`, meaning subdirectories are fully supported. This allows for natural folder organization while maintaining flat URL paths.

---

## Proposed Documentation Structure

```
data/wiki/
├── README.art                          # Documentation index/overview
├── getting-started.art                 # Quick start guide
│
├── core/                              # Vista Core Library Documentation
│   ├── concepts/
│   │   ├── vid-overview.art           # VID dialect introduction
│   │   ├── face-model.art             # Face/facet architecture
│   │   ├── layout-philosophy.art     # Layout system concepts
│   │   ├── state-management.art       # Data binding and state
│   │   └── event-system.art           # Event handling model
│   │
│   ├── tutorials/
│   │   ├── hello-world.art           # First application
│   │   ├── forms-basics.art          # Building forms
│   │   ├── dynamic-interfaces.art     # Live updates
│   │   └── complex-layouts.art       # Advanced layouts
│   │
│   ├── components/
│   │   ├── text-components.art       # text, title, subtitle, label
│   │   ├── buttons-controls.art       # button, key_button
│   │   ├── input-fields.art          # field, input, textarea, select
│   │   ├── selection-controls.art     # checkbox, toggle, radio-group
│   │   ├── sliders-choice.art        # slider, rotary, drop-list
│   │   ├── containers.art            # box, panel, group
│   │   ├── layout-containers.art      # row, col, grid
│   │   ├── navigation-components.art  # tabs, toolbar, menubar
│   │   ├── data-display.art          # text-list, list, table
│   │   ├── visual-divider.art        # divider, spacer, split
│   │   └── canvas-artifacts.art      # canvas element
│   │
│   ├── layout/
│   │   ├── layout-overview.art       # Layout system guide
│   │   ├── across-below.art          # Row/column layout
│   │   ├── grid-system.art           # Grid layout
│   │   ├── spacing-pad.art           # Spacing and padding
│   │   ├── alignment-valign.art      # Alignment options
│   │   ├── origin-offset.art         # Positioning
│   │   └── scope-nesting.art         # Scoped layouts
│   │
│   ├── data-binding/
│   │   ├── binding-overview.art      # Data binding concepts
│   │   ├── state-model.art           # State management
│   │   ├── two-way-binding.art       # Input binding
│   │   ├── sync-state.art            # State synchronization
│   │   ├── auto-sync.art            # Automatic sync
│   │   └── face-updates.art         # Updating faces dynamically
│   │
│   ├── events/
│   │   ├── event-overview.art        # Event system concepts
│   │   ├── click-events.art          # on-click handling
│   │   ├── input-events.art          # on-change, on-input
│   │   ├── mouse-events.art          # on-over, on-out, on-down, on-up
│   │   ├── keyboard-events.art       # on-key, key bindings
│   │   └── focus-events.art          # on-focus, on-blur
│   │
│   └── api-reference/
│       ├── component-functions.art   # All component functions
│       ├── layout-functions.art      # Layout functions
│       ├── state-functions.art       # State management functions
│       ├── event-functions.art       # Event handling functions
│       └── face-functions.art        # Face manipulation functions
│
├── graphics/                          # Vista Graphics Library Documentation
│   ├── concepts/
│   │   ├── graphics-overview.art    # Introduction to Vista Graphics
│   │   ├── draw-model.art           # Draw dialect concepts
│   │   ├── coordinate-systems.art    # Math, center, VID coordinates
│   │   └── canvas-basics.art        # Canvas setup and usage
│   │
│   ├── tutorials/
│   │   ├── drawing-primitives.art   # Lines, shapes basics
│   │   ├── gradients-fills.art      # Gradients and fills
│   │   ├── text-images.art          # Text and image rendering
│   │   ├── transformations.art      # Rotate, scale, translate
│   │   └── compositing-layers.art   # Push/pop and compositing
│   │
│   ├── drawing/
│   │   ├── primitives.art           # line, box, circle, ellipse
│   │   ├── polygons.art             # polygon drawing
│   │   ├── paths-art               # Path operations
│   │   └── pen-fill-art             # pen, fill-pen styles
│   │
│   ├── text-fonts/
│   │   ├── text-rendering.art       # text command usage
│   │   ├── font-settings.art        # font command and properties
│   │   ├── text-alignment.art       # text-baseline, text-align
│   │   └── typography-tips.art      # Typography best practices
│   │
│   ├── images/
│   │   ├── image-drawing.art        # image command
│   │   ├── image-scaling.art        # Size and scaling
│   │   ├── sprite-sheets.art        # Sprite animation
│   │   └── pixel-art-mode.art       # smooth off for pixel art
│   │
│   ├── transforms/
│   │   ├── transform-overview.art    # Transform system
│   │   ├── translate-art            # translate command
│   │   ├── rotate-art               # rotate command
│   │   ├── scale-art                # scale command
│   │   ├── skew-art                 # skew command
│   │   └── coord-systems-art        # coord-system command
│   │
│   ├── colors/
│   │   ├── color-overview.art       # Color handling
│   │   ├── named-colors.art         # CSS named colors
│   │   ├── rgb-rgba-art             # RGB and RGBA colors
│   │   └── gradient-fills.art       # linear/radial gradients
│   │
│   ├── animation/
│   │   ├── animation-basics.art     # Animation concepts
│   │   ├── frame-animation.art     # Frame-based animation
│   │   ├── transition-effects.art   # Smooth transitions
│   │   └── particle-systems.art     # Particle effects
│   │
│   └── api-reference/
│       ├── draw-commands.art         # All draw commands
│       ├── transform-commands.art   # Transform commands
│       ├── color-commands.art       # Color and gradient commands
│       └── graphics-functions.art   # Helper functions
│
└── shared/
    ├── styles/
    │   ├── css-classes.art          # All CSS classes reference
    │   ├── theme-variables.art      # Theme customization
    │   └── responsive-design.art    # Responsive considerations
    │
    ├── patterns/
    │   ├── common-patterns.art      # Reusable patterns
    │   └── anti-patterns.art       # What to avoid
    │
    ├── migration/
    │   ├── from-rebol-view.art     # Migration from Rebol
    │   ├── vid-compatibility.art   # VID compatibility
    │   └── vid-parity.art          # VID parity status
    │
    └── troubleshooting/
        ├── common-issues.art       # Common problems and solutions
        ├── debugging-tips.art      # Debugging techniques
        └── performance-tips.art    # Performance optimization
```

---

## Metadata Strategy

### Category Values

Categories serve as the primary navigation organization. Use these standardized category names:

| Category | Description |
|----------|-------------|
| `Getting Started` | Quick start and introductory content |
| `Concepts` | Foundational concepts and architecture |
| `Tutorials` | Step-by-step learning guides |
| `Components` | UI component documentation |
| `Layout` | Layout system documentation |
| `Data Binding` | State and binding documentation |
| `Events` | Event handling documentation |
| `Graphics` | Graphics drawing documentation |
| `Transforms` | Transform and coordinate documentation |
| `Colors` | Color and gradient documentation |
| `Animation` | Animation documentation |
| `API Reference` | Function and API documentation |
| `Styles` | Styling documentation |
| `Patterns` | Design patterns |
| `Migration` | Migration guides |
| `Troubleshooting` | Debugging and issue resolution |

### Layout Types

- `docpage`: Standard documentation page with sidebar navigation
- `page`: Standalone page without sidebar (landing pages, API index)
- `tutorial`: Tutorial-style page with steps and examples

### Tags Convention

Tags help with search and cross-referencing. Use consistent tags:

```arturo
# [
#   "title": "Component Name"
#   "layout": "docpage"
#   "category": "Components"
#   "tags": ["component", "ui", "input", "example"]
#   "body": { ... }
# ]
```

---

## File Naming Conventions

### Principles
1. **Descriptive**: Filenames should clearly indicate content
2. **Kebab-case**: Use lowercase with hyphens (e.g., `data-binding.art`)
3. **Topic-based**: Group related concepts in same file when possible
4. **Avoid redundancy**: Don't repeat category in filename

### Examples
| Content | Filename |
|---------|----------|
| Data binding overview | `data-binding-overview.art` |
| Two-way binding | `two-way-binding.art` |
| Radio group component | `radio-group.art` |
| Button controls | `button-controls.art` |

---

## URL Structure

The build system generates URLs based on file paths:

| File Path | Generated URL |
|-----------|---------------|
| `data/wiki/getting-started.art` | `/wiki/getting-started/` |
| `data/wiki/core/concepts/vid-overview.art` | `/wiki/core/concepts/vid-overview/` |
| `data/wiki/graphics/transforms/rotate.art` | `/wiki/graphics/transforms/rotate/` |

---

## Sidebar Navigation Structure

The sidebar should reflect the folder hierarchy:

```
📚 Documentation
├── Getting Started
│   ├── README
│   └── Getting Started
├── Vista Core
│   ├── Concepts
│   │   ├── VID Overview
│   │   ├── Face Model
│   │   └── ...
│   ├── Tutorials
│   │   ├── Hello World
│   │   └── ...
│   ├── Components
│   │   ├── Text Components
│   │   ├── Button Controls
│   │   └── ...
│   ├── Layout
│   ├── Data Binding
│   └── Events
└── Vista Graphics
    ├── Concepts
    ├── Tutorials
    ├── Drawing
    ├── Transforms
    ├── Colors
    └── Animation
```

---

## Template System Extensions

### Recommended New Templates

1. **`docpage.html`** (existing): Standard documentation with sidebar
2. **`page.html`** (existing): Standalone page
3. **`tutorial.html`**: Tutorial-style with steps, examples, and "Try it" sections
4. **`api-page.html`**: API reference with function signatures and parameters
5. **`example.html`**: Embeddable example viewer

### Example Template Structure

For tutorial pages, include:
- Estimated time
- Difficulty level
- Prerequisites
- Learning objectives
- Step-by-step sections
- Interactive examples
- "Try it yourself" sections
- Challenge exercises

---

## Implementation Priority

### Phase 1: Core Foundation
1. Create folder structure
2. Move existing files to appropriate locations
3. Create README/index page
4. Set up category metadata

### Phase 2: Core Library Documentation
1. Concepts section
2. Component documentation
3. Layout documentation
4. Data binding documentation
5. Event documentation

### Phase 3: Graphics Documentation
1. Graphics concepts
2. Drawing tutorials
3. Transform documentation
4. Color/gradient documentation
5. Animation documentation

### Phase 4: Cross-Cutting
1. API reference pages
2. Migration guides
3. Troubleshooting guides
4. Pattern library

---

## Migration of Existing Files

| Existing File | New Location |
|---------------|--------------|
| `data/wiki/getting-started.art` | `data/wiki/getting-started.art` |
| `data/wiki/vid-overview.art` | `data/wiki/core/concepts/vid-overview.art` |
| `data/wiki/README.art` | `data/wiki/README.art` |

---

## Build System Considerations

### Current Behavior
The build system uses `list.recursive` to find all `.art` files, meaning:
- Files in subdirectories are automatically included
- Category metadata determines sidebar grouping
- Tags enable filtering and search

### Recommended Enhancements
1. **Folder-based category inference**: Auto-detect category from folder name if not specified
2. **Alphabetical sorting**: Sort wiki index items alphabetically within categories
3. **Breadcrumb generation**: Generate breadcrumbs from folder structure
4. **Cross-reference linking**: Parse `See Also` sections to create links
5. **Search index**: Generate a search index with all pages and tags

---

## Next Steps

1. **Create folder structure**: `mkdir -p data/wiki/core/{concepts,tutorials,components,layout,data-binding,events,api-reference}`
2. **Create folder structure**: `mkdir -p data/wiki/graphics/{concepts,tutorials,drawing,text-fonts,images,transforms,colors,animation,api-reference}`
3. **Move existing files** to appropriate locations
4. **Update metadata** with proper categories
5. **Create index pages** for each section
6. **Add new documentation pages** following the structure
7. **Test build system** with new structure

---

## Summary

This folder structure provides:
- **Clear organization** by library and topic type
- **Scalable architecture** for adding new documentation
- **Consistent navigation** through standardized categories
- **Easy maintenance** with natural file organization
- **Search-friendly** structure with tags and metadata
- **Build system compatibility** with existing `tools/build.art`
