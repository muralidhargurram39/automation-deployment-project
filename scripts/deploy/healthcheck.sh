#!/bin/bash

set -e

echo "========================================"
echo "Application Health Check"
echo "========================================"

required_vars=(
    CONTAINER_NAME
    HOST_PORT
)

for var in "${required_vars[@]}"
do
    if [ -z "${!var}" ]; then
        echo "ERROR: Environment variable '$var' is not set."
        exit 1
    fi
done

URL="http://localhost:${HOST_PORT}"

echo
echo "Checking application at:"
echo "$URL"
echo

MAX_RETRIES=30

for i in $(seq 1 $MAX_RETRIES)
do
    STATUS=$(curl -s -o /dev/null -w "%{http_code}" "$URL" || true)

    if [ "$STATUS" = "200" ]; then
        echo
        echo "Application is UP."
        echo
        curl -I "$URL"
        exit 0
    fi

    echo "Attempt ${i}/${MAX_RETRIES}: HTTP ${STATUS} - waiting..."

    sleep 5
done

echo
echo "ERROR: Application failed health check."

docker logs "$CONTAINER_NAME" --tail 100

exit 1
