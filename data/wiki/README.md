---
title: Vista Documentation
layout: page
category: Home
tags: ["index", "overview", "documentation"]
---

# Vista Documentation

Welcome to the Vista documentation. Vista is a declarative UI framework for Arturo inspired by Rebol/View.

## Libraries

- **Vista Core** - UI components, layout, data binding, events

- **Vista Graphics** - Canvas 2D graphics and drawing

## Getting Started

- [Getting Started](/wiki/getting-started/) - Quick start guide

- [Hello World Tutorial](/wiki/core/tutorials/hello-world/) - Your first Vista app

- [VID Overview](/wiki/core/concepts/vid-overview/) - Introduction to the VID dialect

## Vista Core

- [Concepts](/wiki/core/concepts/) - Architecture and design

- [Tutorials](/wiki/core/tutorials/) - Step-by-step guides

- [Components](/wiki/core/components/) - UI component reference

- [Layout](/wiki/core/layout/) - Layout system reference

- [Data Binding](/wiki/core/data-binding/) - State and binding

- [Events](/wiki/core/events/) - Event handling

## Vista Graphics

- [Concepts](/wiki/graphics/concepts/) - Graphics fundamentals

- [Tutorials](/wiki/graphics/tutorials/) - Graphics guides

- [Drawing](/wiki/graphics/drawing/) - Drawing commands

- [Transforms](/wiki/graphics/transforms/) - Transformations

- [Colors](/wiki/graphics/colors/) - Colors and gradients

- [Animation](/wiki/graphics/animation/) - Animation techniques

## Building the Docs
Edit files in `data/wiki/` and rebuild:

`
arturo tools/build.art
`

## File Format
Wiki pages use Arturo block comments. See [wiki-template.art](/wiki/wiki-template/) for a template.
