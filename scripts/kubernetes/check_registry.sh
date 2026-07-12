#!/bin/bash

set -euo pipefail

echo "========================================"
echo "Verify Docker Image in Nexus"
echo "========================================"

required_vars=(
    DOCKER_REGISTRY
    DOCKER_REPOSITORY
    IMAGE_NAME
    VERSION
    NEXUS_USERNAME
    NEXUS_PASSWORD
)

for var in "${required_vars[@]}"
do
    if [ -z "${!var:-}" ]; then
        echo "ERROR: Environment variable '$var' is not set."
        exit 1
    fi
done

IMAGE="${DOCKER_REGISTRY}/${DOCKER_REPOSITORY}/${IMAGE_NAME}:${VERSION}"

echo
echo "Registry   : ${DOCKER_REGISTRY}"
echo "Repository : ${DOCKER_REPOSITORY}"
echo "Image      : ${IMAGE_NAME}"
echo "Version    : ${VERSION}"

echo
echo "Checking Docker image in Nexus..."

HTTP_CODE=$(curl \
    --silent \
    --output /dev/null \
    --write-out "%{http_code}" \
    --user "${NEXUS_USERNAME}:${NEXUS_PASSWORD}" \
    -H "Accept: application/vnd.docker.distribution.manifest.v2+json" \
    "http://${DOCKER_REGISTRY}/v2/${DOCKER_REPOSITORY}/${IMAGE_NAME}/manifests/${VERSION}")

if [ "$HTTP_CODE" = "200" ]; then
    echo
    echo "✓ Image exists in Nexus."
    echo "Verification PASSED."
    exit 0
fi

echo
echo "✗ Image not found in Nexus."
echo "HTTP Status : ${HTTP_CODE}"
echo "Verification FAILED."

exit 1
