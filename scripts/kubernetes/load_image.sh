#!/bin/bash

set -euo pipefail

echo "========================================"
echo "Load Docker Image into Kind"
echo "========================================"

#########################################################
# Validate Environment Variables
#########################################################

required_vars=(
    DOCKER_REGISTRY
    DOCKER_REPOSITORY
    IMAGE_NAME
    VERSION
    KIND_CLUSTER_NAME
)

for var in "${required_vars[@]}"
do
    if [ -z "${!var:-}" ]; then
        echo
        echo "ERROR: Environment variable '$var' is not set."
        exit 1
    fi
done

#########################################################
# Build Image Name
#########################################################

IMAGE="${DOCKER_REGISTRY}/${DOCKER_REPOSITORY}/${IMAGE_NAME}:${VERSION}"

echo
echo "Cluster : ${KIND_CLUSTER_NAME}"
echo "Image   : ${IMAGE}"

#########################################################
# Verify Kind Cluster
#########################################################

echo
echo "Checking Kind cluster..."

if ! kind get clusters | grep -qx "${KIND_CLUSTER_NAME}"
then
    echo
    echo "ERROR: Kind cluster '${KIND_CLUSTER_NAME}' does not exist."
    exit 1
fi

echo "✓ Kind cluster found."

#########################################################
# Verify Docker Image Exists Locally
#########################################################

echo
echo "Checking Docker image..."

if ! docker image inspect "${IMAGE}" >/dev/null 2>&1
then
    echo
    echo "ERROR: Docker image not found."
    echo "Image : ${IMAGE}"
    exit 1
fi

echo "✓ Docker image found."

#########################################################
# Load Image into Kind
#########################################################

echo
echo "Loading image into Kind..."

kind load docker-image \
    "${IMAGE}" \
    --name "${KIND_CLUSTER_NAME}"

#########################################################
# Completed
#########################################################

echo
echo "========================================"
echo "Image loaded successfully."
echo "========================================"

echo
echo "Loaded Image : ${IMAGE}"
echo "Cluster      : ${KIND_CLUSTER_NAME}"
