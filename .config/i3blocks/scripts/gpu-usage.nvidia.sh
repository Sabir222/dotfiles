#!/bin/bash
if ! command -v nvidia-smi &>/dev/null; then
    echo "n/a"
    exit 0
fi
nvidia-smi --query-gpu=utilization.gpu --format=csv,noheader,nounits | awk '{print $1 "%"}'
