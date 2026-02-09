---
title: Block Normalization
layout: docpage
category: API Reference
tags: ["parsing", "normalize", "block", "graphics", "draw"]
---

# Block Normalization

Block normalization handles the parsing and normalization of draw blocks, ensuring that compound keywords like `fill-pen` and `line-width` survive Arturo tokenization correctly.

## Overview
When Arturo tokenizes code, compound words with hyphens may be split into separate tokens. The normalization process recombines these tokens to restore the intended keywords.

## vg_normalize_block
Normalizes a draw block by recombining hyphenated keywords.

`
normalized: vg_normalize_block block
`

### Parameters

- `block` - The draw block to normalize

### Returns
A new block with compound keywords properly combined.

## How It Works
The function scans the block for patterns like:

`
[fill - pen box 0 0 100 100]
`
And combines them into:

`
[fill-pen box 0 0 100 100]
`

## Supported Compound Keywords

- `fill-pen` - Fill color/gradient

- `line-width` - Stroke width

- `line-cap` - Line end style

- `line-join` - Line corner style

- `text-align` - Text alignment

- `text-baseline` - Text baseline

- `coord-system` - Coordinate system

- `anti-aliased` - Anti-aliasing toggle

## Example
`
; Input block (after tokenization)
rawBlock: [fill - pen red line - width 2 box 0 0 100 100]

; Normalized block
normalized: vg_normalize_block rawBlock
; Result: [fill-pen red line-width 2 box 0 0 100 100]
`

## When Normalization Happens
Block normalization is typically applied automatically when:

- Parsing draw blocks for canvas rendering

- Processing VID style specifications

- Handling inline draw dialect code

## Implementation Details
The function:

- Iterates through block tokens

- Identifies word/symbol/word patterns with hyphens

- Combines matched patterns into single words

- Preserves attribute labels correctly

- Returns a new normalized block

## See Also

- [Draw Model](/wiki/graphics/concepts/draw-model/) - Draw dialect concepts

- [Draw Commands](/wiki/graphics/api-reference/draw-commands/) - Drawing API

</ul
