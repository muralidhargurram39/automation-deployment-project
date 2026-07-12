#!/bin/bash

set -e

echo "========================================"
echo "Kubernetes Rollout Status"
echo "========================================"

NAMESPACE=${NAMESPACE:-automation-deployment}
DEPLOYMENT_NAME=${DEPLOYMENT_NAME:-automation-deployment}

echo
echo "Namespace  : ${NAMESPACE}"
echo "Deployment : ${DEPLOYMENT_NAME}"
echo

kubectl rollout status deployment/${DEPLOYMENT_NAME} \
    -n ${NAMESPACE}

echo
echo "Rollout History"
kubectl rollout history deployment/${DEPLOYMENT_NAME} \
    -n ${NAMESPACE}

echo
echo "========================================"
echo "Rollout Verification Successful"
echo "========================================"
