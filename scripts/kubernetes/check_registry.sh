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

URL="http://${DOCKER_REGISTRY}/v2/${DOCKER_REPOSITORY}/${IMAGE_NAME}/manifests/${VERSION}"

echo
echo "Registry   : ${DOCKER_REGISTRY}"
echo "Repository : ${DOCKER_REPOSITORY}"
echo "Image      : ${IMAGE_NAME}"
echo "Version    : ${VERSION}"

echo
echo "Checking Docker image in Nexus..."
echo "URL : ${URL}"
echo

set +e

HTTP_CODE=$(
curl \
    --silent \
    --show-error \
    --location \
    --output /dev/null \
    --write-out "%{http_code}" \
    --user "${NEXUS_USERNAME}:${NEXUS_PASSWORD}" \
    -H "Accept: application/vnd.docker.distribution.manifest.v2+json" \
    "${URL}"
)

CURL_EXIT=$?

set -e

if [ ${CURL_EXIT} -ne 0 ]; then

    echo "ERROR: Unable to connect to Docker Registry."
    echo "curl exit code : ${CURL_EXIT}"

    exit 1

fi

case "${HTTP_CODE}" in

200)

    echo
    echo "✓ Image exists in Nexus."
    echo "Verification PASSED."
    ;;

401)

    echo
    echo "ERROR: Authentication failed."
    exit 1
    ;;

404)

    echo
    echo "ERROR: Image tag not found."
    exit 1
    ;;

*)

    echo
    echo "ERROR: Unexpected HTTP response."
    echo "HTTP Status : ${HTTP_CODE}"
    exit 1
    ;;

esac
