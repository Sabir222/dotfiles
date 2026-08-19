#!/bin/bash
free -b | awk '/^Swap/ {
    total = $2 / 1073741824
    used = $3 / 1073741824
    if (used < 1) cls = "ok"
    else if (used < 4) cls = "warn"
    else cls = "crit"
    printf "%.1fGi/%.1fGi\n%.1fGi/%.1fGi\n%s\n", used, total, used, total, cls
}'
