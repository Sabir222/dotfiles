#!/bin/bash

# Check if Docker daemon is running
if ! systemctl is-active --quiet docker; then
    echo "🐳: OFF"
    echo "🐳: OFF"
    echo "off"
    exit 0
fi

# Check if user has docker permissions
if ! docker info >/dev/null 2>&1; then
    echo "🐳: NO PERM"
    echo "🐳: NO PERM"
    echo "noperm"
    exit 0
fi

# Get Docker info with better error handling
CONTAINERS_RUNNING=$(docker ps -q 2>/dev/null | wc -l)
CONTAINERS_TOTAL=$(docker ps -a -q 2>/dev/null | wc -l)
IMAGES=$(docker images -q 2>/dev/null | wc -l)

# Format output
if [ "$CONTAINERS_RUNNING" -gt 0 ]; then
    echo "🐳 $CONTAINERS_RUNNING/$CONTAINERS_TOTAL ($IMAGES img)"
    echo "🐳 $CONTAINERS_RUNNING/$CONTAINERS_TOTAL"
    echo "running"
else
    echo "🐳 0/$CONTAINERS_TOTAL ($IMAGES img)"
    echo "🐳 0/$CONTAINERS_TOTAL"
    echo "idle"
fi
