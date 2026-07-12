#!/bin/bash

set -e

echo "========================================"
echo "Kubernetes Rollback"
echo "========================================"

# Default values
NAMESPACE=${NAMESPACE:-automation-deployment}
DEPLOYMENT_NAME=${DEPLOYMENT_NAME:-automation-deployment}

echo
echo "Namespace  : ${NAMESPACE}"
echo "Deployment : ${DEPLOYMENT_NAME}"
echo

echo "Current Rollout History"
kubectl rollout history deployment/${DEPLOYMENT_NAME} \
    -n ${NAMESPACE}

echo
echo "Rolling back deployment..."

kubectl rollout undo deployment/${DEPLOYMENT_NAME} \
    -n ${NAMESPACE}

echo
echo "Waiting for rollout..."

kubectl rollout status deployment/${DEPLOYMENT_NAME} \
    -n ${NAMESPACE}

echo
echo "Updated Rollout History"

kubectl rollout history deployment/${DEPLOYMENT_NAME} \
    -n ${NAMESPACE}

echo
echo "========================================"
echo "Rollback completed successfully."
echo "========================================"
