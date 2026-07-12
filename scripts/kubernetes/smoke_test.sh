#!/bin/bash

set -e

echo "========================================"
echo "Kubernetes Smoke Test"
echo "========================================"

# Default values
NAMESPACE=${NAMESPACE:-automation-deployment}
SERVICE_NAME=${SERVICE_NAME:-automation-service}

echo
echo "Namespace : ${NAMESPACE}"
echo "Service   : ${SERVICE_NAME}"
echo

kubectl run curl-test \
    --rm \
    -i \
    --restart=Never \
    --image=curlimages/curl \
    -- \
    curl -I http://${SERVICE_NAME}.${NAMESPACE}.svc.cluster.local

echo
echo "========================================"
echo "Smoke Test Passed"
echo "========================================"
