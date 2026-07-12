#!/bin/bash

set -euo pipefail

echo "========================================"
echo "Building Docker Image"
echo "========================================"

# Validate required environment variables
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
IMAGE_VERSION="${DOCKER_REGISTRY}/${DOCKER_REPOSITORY}/${IMAGE_NAME}:${VERSION}"
IMAGE_LATEST="${DOCKER_REGISTRY}/${DOCKER_REPOSITORY}/${IMAGE_NAME}:latest"

echo
echo "Version Image : ${IMAGE_VERSION}"
echo "Latest Image  : ${IMAGE_LATEST}"
echo

docker build \
    --build-arg APP_VERSION="${VERSION}" \
    -t "${IMAGE_VERSION}" \
    -t "${IMAGE_LATEST}" \
    .

echo
echo "Docker build completed successfully."

docker image inspect "${IMAGE_VERSION}" >/dev/null

echo
echo "Image verification successful."

docker images | grep "${IMAGE_NAME}"
