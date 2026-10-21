#!/bin/bash
count=$(dnf check-update --quiet 2>/dev/null | awk 'NF >= 3 && $1 ~ /\./ { c++ } END { print c+0 }')
echo "  $count updates"
