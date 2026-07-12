#!/bin/bash

set -e

echo "========================================"
echo "Load Docker Image into Kind"
echo "========================================"

# Default values (can be overridden by environment variables)
DOCKER_REGISTRY=${DOCKER_REGISTRY:-nexus:8083}
DOCKER_REPOSITORY=${DOCKER_REPOSITORY:-docker-hosted}
IMAGE_NAME=${IMAGE_NAME:-automation-deployment}
VERSION=${VERSION:-latest}
K8S_CLUSTER=${K8S_CLUSTER:-automation-deployment-cluster}

IMAGE="${DOCKER_REGISTRY}/${DOCKER_REPOSITORY}/${IMAGE_NAME}:${VERSION}"

echo
echo "Cluster : ${K8S_CLUSTER}"
echo "Image   : ${IMAGE}"
echo

kind load docker-image "$IMAGE" --name "$K8S_CLUSTER"

echo "Verifying image inside Kind..."

docker exec "${K8S_CLUSTER}-control-plane" \
ctr -n k8s.io images ls | grep "$IMAGE"

echo "Image verified."

if ! kind get clusters | grep -qx "${K8S_CLUSTER}"; then
    echo "ERROR: Kind cluster '${K8S_CLUSTER}' does not exist."
    exit 1
fi

echo
echo "Image loaded successfully."
