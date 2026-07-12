#!/bin/bash

set -e

echo "========================================"
echo "Docker Login"
echo "========================================"

if [ -z "$DOCKER_USER" ] || [ -z "$DOCKER_PASS" ]; then
    echo "ERROR: Docker credentials not found."
    exit 1
fi

echo "$DOCKER_PASS" | docker login nexus:8083 \
    --username "$DOCKER_USER" \
    --password-stdin

echo
echo "Docker login successful."
