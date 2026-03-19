#!/bin/bash
set -euo pipefail

# Determine the remote tracking point for the current branch.
# Only rewrites commits that haven't been pushed yet.
upstream=$(git rev-parse --verify '@{upstream}' 2>/dev/null || true)

if [ -z "$upstream" ]; then
    echo "pre-push: No upstream tracking branch found. Skipping." >&2
    exit 0
fi

# Check unpushed commits for Co-Authored-By lines.
if ! git log --format='%B' "$upstream"..HEAD | grep -qi '^Co-Authored-By:'; then
    exit 0
fi

echo "pre-push: Stripping Co-Authored-By trailers from unpushed commits..." >&2

FILTER_BRANCH_SQUELCH_WARNING=1 git filter-branch -f --msg-filter \
    'sed -e "/^[Cc]o-[Aa]uthored-[Bb]y:/d" -e :a -e "/^\n*$/{\$d;N;ba;}"' \
    "$upstream"..HEAD

echo "pre-push: Done. Commits rewritten." >&2
