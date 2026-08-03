#!/bin/bash
df -B1 / | awk 'NR==2 {
    free = $4 / 1073741824
    if (free < 40) cls = "crit"
    else if (free < 80) cls = "warn"
    else cls = "ok"
    printf "%.1fG free\n%.1fG free\n%s\n", free, free, cls
}'
