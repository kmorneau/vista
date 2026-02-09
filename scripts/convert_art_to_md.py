#!/usr/bin/env python3
"""
Convert Arturo .art wiki files to Markdown
"""

import re
import os
from pathlib import Path

def html_to_markdown(html):
    """Convert HTML to Markdown"""
    md = html

    # Headers
    md = re.sub(r'<h1[^>]*>(.*?)</h1>', r'# \1', md, flags=re.DOTALL)
    md = re.sub(r'<h2[^>]*>(.*?)</h2>', r'## \1', md, flags=re.DOTALL)
    md = re.sub(r'<h3[^>]*>(.*?)</h3>', r'### \1', md, flags=re.DOTALL)
    md = re.sub(r'<h4[^>]*>(.*?)</h4>', r'#### \1', md, flags=re.DOTALL)

    # Bold/strong
    md = re.sub(r'<strong>(.*?)</strong>', r'**\1**', md, flags=re.DOTALL)
    md = re.sub(r'<b>(.*?)</b>', r'**\1**', md, flags=re.DOTALL)

    # Italic/em
    md = re.sub(r'<em>(.*?)</em>', r'*\1*', md, flags=re.DOTALL)
    md = re.sub(r'<i>(.*?)</i>', r'*\1*', md, flags=re.DOTALL)

    # Code inline
    md = re.sub(r'<code>(.*?)</code>', r'`\1`', md, flags=re.DOTALL)

    # Lists
    md = re.sub(r'<ul[^>]*>', '', md)
    md = re.sub(r'</ul>', '', md)
    md = re.sub(r'<ol[^>]*>', '', md)
    md = re.sub(r'</ol>', '', md)
    md = re.sub(r'<li[^>]*>(.*?)</li>', r'- \1\n', md, flags=re.DOTALL)

    # Paragraphs - must be before line breaks
    md = re.sub(r'<p[^>]*>(.*?)</p>', r'\1\n\n', md, flags=re.DOTALL)

    # Line breaks
    md = re.sub(r'<br\s*/?>', '\n', md)

    # Links
    md = re.sub(r'<a href="([^"]*)">(.*?)</a>', r'[\2](\1)', md, flags=re.DOTALL)

    # Code blocks - use triple backticks for multi-line code
    md = re.sub(r'<pre><code>\s*(.*?)\s*</code></pre>', r'```\n\1\n```', md, flags=re.DOTALL)
    
    # Remove any remaining HTML tags
    md = re.sub(r'<[^>]+>', '', md)

    # Clean up extra whitespace
    md = re.sub(r'\n{3,}', '\n\n', md)
    md = md.strip()

    return md

def parse_art_file(content):
    """Parse Arturo .art file content"""
    # The format is:
    # #[
    #   "title": "..."
    #   "layout": "..."
    #   "body": {
    #     <html content>
    #   }
    # ]
    
    # Find start of block - look for #[
    start_idx = content.find('#[{')
    if start_idx == -1:
        start_idx = content.find('#[ ')
        if start_idx == -1:
            start_idx = content.find('#[')
    
    if start_idx == -1:
        return None
    
    # Find the end of the block comment - look for ]
    end_idx = content.rfind(']')
    if end_idx == -1:
        return None
    
    block_content = content[start_idx+2:end_idx].strip()
    
    # Find "body": { and extract content until the matching closing }
    body_start = block_content.find('"body": {')
    if body_start == -1:
        body_start = block_content.find('"body":{')
    
    if body_start == -1:
        return None
    
    # Skip past "body": {
    search_start = body_start + len('"body": {')
    
    # Find the matching closing brace (accounting for nested braces in HTML)
    brace_count = 1
    i = search_start
    while i < len(block_content) and brace_count > 0:
        if block_content[i] == '{':
            brace_count += 1
        elif block_content[i] == '}':
            brace_count -= 1
        i += 1
    
    body_html = block_content[search_start:i-1].strip()
    
    # Remove leading/trailing braces if present
    body_html = body_html.strip()
    if body_html.startswith('{'):
        body_html = body_html[1:]
    if body_html.endswith('}'):
        body_html = body_html[:-1]
    body_html = body_html.strip()
    
    # Remove common leading indentation (4-8 spaces)
    body_html = re.sub(r'^[ ]{4,}', '', body_html, flags=re.MULTILINE)
    
    # Extract metadata from the block (before "body")
    metadata_section = block_content[:body_start]
    
    # Extract title
    title_match = re.search(r'"title":\s*"([^"]*)"', metadata_section)
    title = title_match.group(1) if title_match else ""

    # Extract layout
    layout_match = re.search(r'"layout":\s*"([^"]*)"', metadata_section)
    layout = layout_match.group(1) if layout_match else ""

    # Extract category
    category_match = re.search(r'"category":\s*"([^"]*)"', metadata_section)
    category = category_match.group(1) if category_match else ""

    # Extract tags
    tags_match = re.search(r'"tags":\s*\[([^\]]*)\]', metadata_section)
    tags = tags_match.group(1) if tags_match else ""

    return {
        'title': title,
        'layout': layout,
        'category': category,
        'tags': tags,
        'body': body_html
    }

def convert_file(input_path, output_path):
    """Convert a single .art file to .md"""
    print(f"Converting: {input_path}")

    with open(input_path, 'r', encoding='utf-8') as f:
        content = f.read()

    parsed = parse_art_file(content)
    if parsed is None:
        print(f"  -> ERROR: Could not parse file")
        return
    
    body_md = html_to_markdown(parsed['body'])

    md_content = f"""---
title: {parsed['title']}
layout: {parsed['layout']}
category: {parsed['category']}
tags: [{parsed['tags']}]
---

{body_md}
"""

    # Ensure output directory exists
    os.makedirs(os.path.dirname(output_path), exist_ok=True)

    with open(output_path, 'w', encoding='utf-8') as f:
        f.write(md_content)

    print(f"  -> {output_path}")

def find_art_files(directory):
    """Find all .art files in directory recursively"""
    art_files = []
    for root, dirs, files in os.walk(directory):
        for file in files:
            if file.endswith('.art'):
                art_files.append(os.path.join(root, file))
    return sorted(art_files)

def main():
    wiki_dir = "data/wiki"
    art_files = find_art_files(wiki_dir)

    print(f"Found {len(art_files)} .art files")
    print()

    for art_file in art_files:
        output_file = art_file[:-4] + ".md"  # Replace .art with .md
        convert_file(art_file, output_file)

    print()
    print("Conversion complete!")

if __name__ == "__main__":
    main()
