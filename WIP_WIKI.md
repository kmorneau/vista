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
