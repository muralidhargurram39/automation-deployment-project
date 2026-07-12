#!/bin/bash

set -euo pipefail

echo "========================================"
echo "Generate Helm Runtime Values"
echo "========================================"

#########################################################
# Validate Environment Variables
#########################################################

required_vars=(
    DOCKER_REGISTRY
    DOCKER_REPOSITORY
    IMAGE_NAME
    VERSION
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
# Create Target Directory
#########################################################

mkdir -p target

#########################################################
# Generate Runtime Values
#########################################################

cat > target/runtime-values.yaml <<EOF
image:
  registry: ${DOCKER_REGISTRY}
  repository: ${DOCKER_REPOSITORY}
  name: ${IMAGE_NAME}
  tag: "${VERSION}"
EOF

#########################################################
# Verify File
#########################################################

if [ ! -f target/runtime-values.yaml ]; then
    echo
    echo "ERROR: Failed to create runtime-values.yaml"
    exit 1
fi

echo
echo "Generated runtime-values.yaml"
echo

cat target/runtime-values.yaml

echo
echo "Runtime values generated successfully."
