#!/bin/bash

set -e

echo "========================================"
echo "Pull Docker Image"
echo "========================================"

required_vars=(
    DOCKER_REGISTRY
    DOCKER_REPOSITORY
    IMAGE_NAME
    VERSION
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
echo "Removing local image..."

docker image rm -f "$IMAGE_VERSION" || true

echo
echo "Pulling image from Nexus..."

docker pull "$IMAGE_VERSION"

echo
echo "Image pulled successfully."

docker image inspect "$IMAGE_VERSION" >/dev/null

echo
echo "Verification successful."
