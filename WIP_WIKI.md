# WIP Wiki (Arturo) - Proposed Architecture

This repository uses a minimal static site generator driven by Arturo and `.art` page models. The WIP wiki should follow the same approach, using Arturo source files and build-time generation to produce static HTML pages.

## Goals (initial version)
- Static wiki pages that build alongside the existing docs.
- Standard wiki basics: index, page view, and lightweight search (re-use the existing search index).
- Simple authoring: write Arturo files under a wiki data folder.

## Storage
- **Arturo source**: `data/wiki/*.art`
  - File name becomes the **slug** (e.g., `data/wiki/getting-started.art` -> `/wiki/getting-started/`).
  - Title from metadata block. If missing, use the slug.

## Build-time generation
- Extend the static generator to:
  - Scan `data/wiki` for `.art` files.
  - Parse Arturo block comment metadata (title, optional layout).
  - Extract HTML body from the `body` key.
  - Render with the existing templates (`docpage` layout).
  - Emit clean URLs in `dist/wiki/<slug>/index.html`.
  - Append wiki entries to the existing `search.json` index.

## Pages & routes
- `/wiki/` -> wiki index page listing all pages.
- `/wiki/<slug>/` -> rendered Arturo page.

## Arturo file format
Wiki pages use Arturo block comments with metadata and HTML body content:

```arturo
# [
  "title": "Page Title"
  "layout": "docpage"    ; or "page" for standalone pages
  "category": "Getting Started"  ; optional, for organization
  "tags": ["basics", "tutorial"]  ; optional, for search/filtering
  "body": {
    <h1>Page Title</h1>

    <h2>Overview</h2>
    <p>A brief introduction to the topic...</p>

    <h2>Syntax</h2>
    <pre><code>
    ; Arturo code example
    doSomething arg
    </code></pre>

    <h2>Parameters</h2>
    <ul>
      <li><code>arg</code> - Description of the argument</li>
    </ul>

    <h2>Returns</h2>
    <p>The return value...</p>

    <h2>Example</h2>
    <pre><code>
    ; Another example
    result: doSomething "hello"
    print result
    </code></pre>

    <h2>See Also</h2>
    <ul>
      <li><a href="/wiki/related-topic/">Related Topic</a></li>
    </ul>
  }
# ]
```

**Template available at:** [`data/wiki/wiki-template.art`](data/wiki/wiki-template.art)

## Metadata fields
| Field | Required | Description |
|-------|----------|-------------|
| `title` | Yes | The page title displayed in navigation and browser tab |
| `layout` | Yes | Template to use: `docpage` (with sidebar) or `page` (standalone) |
| `category` | No | Section/category for organizing wiki pages |
| `tags` | No | Array of tags for search and filtering |
| `body` | Yes | HTML content to render |

## HTML conventions
- Use `<h1>` for the main page title
- Use `<h2>` for major sections
- Use `<pre><code>` for Arturo code blocks
- Use `<ul>/<li>` for lists and parameter descriptions
- Use `<a href="/wiki/slug/">` for internal wiki links

## Quick reference template
A ready-to-use template is located at [`data/wiki/wiki-template.art`](data/wiki/wiki-template.art). Copy it to create new wiki pages.

## Navigation
- Add a top nav link to **Wiki**.
- Add a sidebar section listing wiki pages (similar to docs nav).

## Non-goals (for now)
- No editing UI or persistence beyond Arturo files.
- No authentication or live server routes.

## Future enhancements
- Page history by storing prior versions under `data/wiki/history/<slug>/timestamp.art`.
- Tags and metadata via additional keys in the block comment.
- Optional per-page TOC generation.

---

## Documentation Progress

### Completed Wiki Pages

The following wiki documentation pages have been created:

#### Core Components
| Page | Path | Description |
|------|------|-------------|
| Button Controls | `data/wiki/core/components/button-controls.art` | Button and key_button components |
| Text Components | `data/wiki/core/components/text-components.art` | text, title, subtitle, label components |
| Containers | `data/wiki/core/components/containers.art` | box, panel, grid, row, col, group, spacer, sensor |
| Data Display | `data/wiki/core/components/data-display.art` | Lists, tables, toolbars, menubars |
| Miscellaneous | `data/wiki/core/components/misc-components.art` | canvas, divider, split, image, progress |

#### Core API Reference
| Page | Path | Description |
|------|------|-------------|
| Face Functions | `data/wiki/core/api-reference/face-functions.art` | Face registration and manipulation API |
| Render Scripts | `data/wiki/core/api-reference/render-scripts.art` | Client-side JavaScript generation |

#### Graphics Colors
| Page | Path | Description |
|------|------|-------------|
| Color Overview | `data/wiki/graphics/colors/color-overview.art` | Color formats and named colors |

#### Graphics API Reference
| Page | Path | Description |
|------|------|-------------|
| Block Normalization | `data/wiki/graphics/api-reference/block-normalization.art` | Draw block parsing and normalization |

### Existing Wiki Pages (Pre-existing)
| Page | Path | Description |
|------|------|-------------|
| Wiki Template | `data/wiki/wiki-template.art` | Template for creating new pages |
| Getting Started | `data/wiki/getting-started.art` | Quick start guide |
| VID Overview | `data/wiki/vid-overview.art` | VID dialect introduction |
| Face Model | `data/wiki/core/concepts/face-model.art` | Face/facet architecture |
| Layout Overview | `data/wiki/core/concepts/layout-overview.art` | Layout system concepts |
| Event System | `data/wiki/core/concepts/event-system.art` | Event handling model |
| State Management | `data/wiki/core/concepts/state-management.art` | Data binding and state |
| Input Fields | `data/wiki/core/components/input-fields.art` | field, input, textarea, select |
| Selection Controls | `data/wiki/core/components/selection-controls.art` | checkbox, toggle, radio-group |
| Sliders & Choice | `data/wiki/core/components/sliders-choice.art` | slider, rotary, drop-list |
| Binding Overview | `data/wiki/core/data-binding/binding-overview.art` | Data binding concepts |
| State Model | `data/wiki/core/data-binding/state-model.art` | State management |
| Two-Way Binding | `data/wiki/core/data-binding/two-way-binding.art` | Input binding |
| Event Overview | `data/wiki/core/events/event-overview.art` | Event system concepts |
| Click Events | `data/wiki/core/events/click-events.art` | on-click handling |
| Input Events | `data/wiki/core/events/input-events.art` | on-change, on-input |
| Graphics Overview | `data/wiki/graphics/concepts/graphics-overview.art` | Introduction to Vista Graphics |
| Coordinate Systems | `data/wiki/graphics/concepts/coordinate-systems.art` | Math, center, VID coordinates |
| Drawing Primitives | `data/wiki/graphics/tutorials/drawing-primitives.art` | Lines, shapes basics |
| Migration from Rebol | `data/wiki/shared/migration/from-rebol-view.art` | Migration guide |
| Common Issues | `data/wiki/shared/troubleshooting/common-issues.art` | Troubleshooting guide |
| Hello World Tutorial | `data/wiki/core/tutorials/hello-world.art` | First application |

### Categories
The documentation is organized into these categories:
- **Getting Started** - Quick start and introductory content
- **Concepts** - Foundational concepts and architecture
- **Tutorials** - Step-by-step learning guides
- **Components** - UI component documentation
- **Layout** - Layout system documentation
- **Data Binding** - State and binding documentation
- **Events** - Event handling documentation
- **Graphics** - Graphics drawing documentation
- **Colors** - Color and gradient documentation
- **API Reference** - Function and API documentation
- **Migration** - Migration guides
- **Troubleshooting** - Debugging and issue resolution
