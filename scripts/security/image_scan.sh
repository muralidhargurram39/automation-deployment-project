#!/bin/bash

set -e

echo "========================================"
echo "Trivy Docker Image Scan"
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

mkdir -p reports/image

IMAGE="${DOCKER_REGISTRY}/${DOCKER_REPOSITORY}/${IMAGE_NAME}:${VERSION}"

COMMON_ARGS="--severity HIGH,CRITICAL"

echo
echo "Scanning image:"
echo "$IMAGE"

trivy image $COMMON_ARGS \
    --format table \
    --output reports/image/trivy.txt \
    "$IMAGE"

trivy image $COMMON_ARGS \
    --format json \
    --output reports/image/trivy.json \
    "$IMAGE"

trivy image $COMMON_ARGS \
    --format sarif \
    --output reports/image/trivy.sarif \
    "$IMAGE"

trivy image $COMMON_ARGS \
    --format template \
    --template "@scripts/security/templates/html.tpl" \
    --output reports/image/trivy.html \
    "$IMAGE"

echo
echo "Image scan completed."

echo
echo "Summary"

trivy image $COMMON_ARGS "$IMAGE"
