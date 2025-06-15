#!/bin/bash
count=$(dnf check-update --quiet | grep -cE '^[a-zA-Z0-9]')
echo "  $count updates"
