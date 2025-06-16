#!/bin/bash
DOTFILES_DIR="$HOME/dotfiles"  # Adjust this path to your dotfiles location

# Check if directory exists and is a git repo
if [ ! -d "$DOTFILES_DIR" ] || [ ! -d "$DOTFILES_DIR/.git" ]; then
    echo "✗"
    echo "✗"
    echo "#FF6B6B"
    exit 0
fi

cd "$DOTFILES_DIR"

# Get git status
STATUS=$(git status --porcelain 2>/dev/null)

if [ -z "$STATUS" ]; then
    # Clean repo
    echo "✓"
    echo "✓"
    echo "#4ECDC4"
else
    # Check for different types of changes
    MODIFIED=$(echo "$STATUS" | grep -c "^ M\|^M ")
    ADDED=$(echo "$STATUS" | grep -c "^A ")
    UNTRACKED=$(echo "$STATUS" | grep -c "^??")
    DELETED=$(echo "$STATUS" | grep -c "^ D\|^D ")
    
    SYMBOLS=""
    COLOR="#FFA500"  # Orange by default
    
    if [ "$UNTRACKED" -gt 0 ]; then
        SYMBOLS="${SYMBOLS} +"
        COLOR="#FFFF00"  # Yellow for new files
    fi
    
    if [ "$MODIFIED" -gt 0 ]; then
        SYMBOLS="${SYMBOLS} ✗"
        COLOR="#FF6B6B"  # Red for modifications
    fi
    
    if [ "$DELETED" -gt 0 ]; then
        SYMBOLS="${SYMBOLS} -"
        COLOR="#FF6B6B"  # Red for deletions
    fi
    
    if [ "$ADDED" -gt 0 ]; then
        SYMBOLS="${SYMBOLS} A"
        COLOR="#4ECDC4"  # Green for staged
    fi
    
    echo "git$SYMBOLS"
    echo "git$SYMBOLS"
    echo "$COLOR"
fi
