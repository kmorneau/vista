#!/bin/bash
# Static site generator for Vista documentation

echo "Starting build..."

# --- init dist ---
echo "Initializing dist folder..."
rm -rf dist
mkdir -p dist

# copy static assets
echo "Copying assets..."
mkdir -p dist/assets
cp src/theme/resources/styles/main.css dist/assets/
cp src/theme/resources/scripts/main.js dist/assets/

# copy icons
echo "Copying icons..."
mkdir -p dist/assets/icons
cp src/theme/resources/icons/*.svg dist/assets/icons/ 2>/dev/null || true

# --- wiki index page ---
echo "Generating wiki index page..."
mkdir -p dist/wiki

cat > dist/wiki/index.html << 'WIKIHTML'
<!doctype html>
<html lang="en">
<head>
  <meta charset="utf-8" />
  <meta name="viewport" content="width=device-width,initial-scale=1" />
  <title>Vista Documentation</title>
  <link rel="stylesheet" href="/assets/main.css" />
</head>
<body>
  <main class="container">
    <h1>Vista Documentation</h1>
    <p>Welcome to the Vista UI framework documentation.</p>
    <h2>Getting Started</h2>
    <ul>
      <li><a href="https://github.com/kmorneau/vista">GitHub Repository</a></li>
      <li><a href="https://github.com/kmorneau/vista/blob/main/README.md">README</a></li>
    </ul>
    <h2>Examples</h2>
    <p>See the <a href="https://github.com/kmorneau/vista/tree/main/examples">examples folder</a> for code samples.</p>
  </main>
  <script src="/assets/main.js"></script>
</body>
</html>
WIKIHTML

echo "Generated: dist/wiki/index.html"

# --- root index page ---
echo "Generating root index page..."

cat > dist/index.html << 'ROOTHTML'
<!doctype html>
<html lang="en">
<head>
  <meta charset="utf-8" />
  <meta name="viewport" content="width=device-width,initial-scale=1" />
  <title>Vista Documentation</title>
  <link rel="stylesheet" href="/assets/main.css" />
</head>
<body>
  <main class="container">
    <h1>Vista Documentation</h1>
    <p>Welcome to Vista! <a href="/wiki/">View the documentation</a>.</p>
  </main>
  <script src="/assets/main.js"></script>
</body>
</html>
ROOTHTML

echo "Generated: dist/index.html"

echo "Build complete!"
