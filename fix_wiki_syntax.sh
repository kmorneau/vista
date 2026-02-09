#!/bin/bash
# Script to fix all remaining wiki files to use #[...] instead of [...]

find data/wiki -name "*.art" -type f | while read -r file; do
    # Check if file starts with [ but not #[
    if head -1 "$file" | grep -q '^\[' && ! head -1 "$file" | grep -q '#\['; then
        echo "Fixing: $file"
        # Replace first [ with #[ and last ] with #]
        sed -i '' '1s/^\[/#[/' "$file"
        # Find the last line that's just ] and add # before it
        sed -i '' '$s/^\]/#]/' "$file"
    else
        echo "Skipping: $file (already fixed or not a wiki file)"
    fi
done
