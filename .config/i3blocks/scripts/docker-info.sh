#!/bin/bash

# Check if Docker daemon is running
if ! systemctl is-active --quiet docker; then
    echo "🐳: OFF"
    echo "🐳: OFF"
    echo "#FF0000"  # Red color
    exit 0
fi

# Check if user has docker permissions
if ! docker info >/dev/null 2>&1; then
    echo "🐳: NO PERM"
    echo "🐳: NO PERM"
    echo "#FFA500"  # Orange color for permission issue
    exit 0
fi

# Get Docker info with better error handling
CONTAINERS_RUNNING=$(docker ps -q 2>/dev/null | wc -l)
CONTAINERS_TOTAL=$(docker ps -a -q 2>/dev/null | wc -l)
IMAGES=$(docker images -q 2>/dev/null | wc -l)

# Debug: uncomment this line to see what's happening
# echo "DEBUG: Running=$CONTAINERS_RUNNING, Total=$CONTAINERS_TOTAL, Images=$IMAGES" >> /tmp/docker-debug.log

# Format output
if [ "$CONTAINERS_RUNNING" -gt 0 ]; then
    echo "🐳 $CONTAINERS_RUNNING/$CONTAINERS_TOTAL ($IMAGES img)"
    echo "🐳 $CONTAINERS_RUNNING/$CONTAINERS_TOTAL"
    echo "#3674B5"  # Blue if containers running
else
    echo "🐳 0/$CONTAINERS_TOTAL ($IMAGES img)"
    echo "🐳 0/$CONTAINERS_TOTAL"
    echo "#0D4715"  # Green if Docker running but no containers
fi
