#!/bin/bash

set -e

echo "========================================"
echo "Deploy Docker Container"
echo "========================================"

required_vars=(
    DOCKER_REGISTRY
    DOCKER_REPOSITORY
    IMAGE_NAME
    VERSION
    CONTAINER_NAME
    HOST_PORT
    DOCKER_NETWORK
)

for var in "${required_vars[@]}"
do
    if [ -z "${!var}" ]; then
        echo "ERROR: Environment variable '$var' is not set."
        exit 1
    fi
done

REGISTRY_PATH="${DOCKER_REGISTRY}/${DOCKER_REPOSITORY}"
IMAGE_VERSION="${REGISTRY_PATH}/${IMAGE_NAME}:${VERSION}"

echo
echo "Removing existing container (if any)..."

docker rm -f "$CONTAINER_NAME" >/dev/null 2>&1 || true

echo
echo "Starting container..."

docker run -d \
    --name "$CONTAINER_NAME" \
    --network "$DOCKER_NETWORK" \
    -p "$HOST_PORT:8080" \
    "$IMAGE_VERSION"

echo
echo "Container deployed successfully."

docker ps --filter "name=$CONTAINER_NAME"
