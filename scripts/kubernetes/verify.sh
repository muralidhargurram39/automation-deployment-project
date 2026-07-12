#!/bin/bash

set -e

echo "========================================"
echo "Verify Kubernetes Deployment"
echo "========================================"

# Default values
NAMESPACE=${NAMESPACE:-automation-deployment}
DEPLOYMENT_NAME=${DEPLOYMENT_NAME:-automation-deployment}
SERVICE_NAME=${SERVICE_NAME:-automation-service}

echo
echo "Namespace  : ${NAMESPACE}"
echo "Deployment : ${DEPLOYMENT_NAME}"
echo "Service    : ${SERVICE_NAME}"
echo

echo "Checking rollout status..."
kubectl rollout status deployment/${DEPLOYMENT_NAME} \
    -n ${NAMESPACE}

echo
echo "Deployment Status"
kubectl get deployment \
    -n ${NAMESPACE}

echo
echo "Pod Status"
kubectl get pods \
    -o wide \
    -n ${NAMESPACE}

echo
echo "Service Status"
kubectl get svc \
    -n ${NAMESPACE}

echo
echo "Endpoints"
kubectl get endpoints \
    -n ${NAMESPACE}

echo
echo "========================================"
echo "Verification completed successfully."
echo "========================================"
