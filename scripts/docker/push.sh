#!/bin/bash

set -e

echo "========================================"
echo "Push Docker Image"
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
IMAGE_LATEST="${REGISTRY_PATH}/${IMAGE_NAME}:latest"

echo
echo "Pushing Version Image..."
docker push "$IMAGE_VERSION"

echo
echo "Pushing Latest Image..."
docker push "$IMAGE_LATEST"

echo
echo "Docker images pushed successfully."
