#!/bin/bash
DOTFILES_DIR="$HOME/dotfiles"

if [ ! -d "$DOTFILES_DIR" ] || [ ! -d "$DOTFILES_DIR/.git" ]; then
    echo "✗"
    echo "✗"
    echo "dirty"
    exit 0
fi

cd "$DOTFILES_DIR"

STATUS=$(git status --porcelain 2>/dev/null)

if [ -z "$STATUS" ]; then
    echo "✓"
    echo "✓"
    echo "ok"
else
    MODIFIED=$(echo "$STATUS" | grep -c "^ M\|^M ")
    ADDED=$(echo "$STATUS" | grep -c "^A ")
    UNTRACKED=$(echo "$STATUS" | grep -c "^??")
    DELETED=$(echo "$STATUS" | grep -c "^ D\|^D ")

    SYMBOLS=""
    if [ "$UNTRACKED" -gt 0 ]; then SYMBOLS="${SYMBOLS} +"; fi
    if [ "$MODIFIED" -gt 0 ]; then SYMBOLS="${SYMBOLS} ✗"; fi
    if [ "$DELETED" -gt 0 ]; then SYMBOLS="${SYMBOLS} -"; fi
    if [ "$ADDED" -gt 0 ]; then SYMBOLS="${SYMBOLS} A"; fi

    echo "$SYMBOLS"
    echo "$SYMBOLS"
    echo "dirty"
fi
