#!/bin/bash
free -b | awk '/^Mem/ {
    used = $3 / 1073741824
    total = $2 / 1073741824
    if (used < 8) cls = "ok"
    else if (used < 11) cls = "warn"
    else cls = "crit"
    printf "%.1fGi/%.1fGi\n%.1fGi/%.1fGi\n%s\n", used, total, used, total, cls
}'
