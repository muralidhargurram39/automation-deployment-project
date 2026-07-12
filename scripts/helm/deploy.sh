#!/bin/bash

set -euo pipefail

echo "========================================"
echo "Helm Deployment"
echo "========================================"

#########################################################
# Configuration
#########################################################

RELEASE_NAME="${RELEASE_NAME:-automation-deployment}"
NAMESPACE="${K8S_NAMESPACE:-automation-deployment}"

CHART_DIR="${CHART_DIR:-helm/automation-deployment}"

VALUES_FILE="${VALUES_FILE:-${CHART_DIR}/values.yaml}"
RUNTIME_VALUES="${RUNTIME_VALUES:-target/runtime-values.yaml}"

ROLLOUT_TIMEOUT="${ROLLOUT_TIMEOUT:-300s}"
HELM_TIMEOUT="${HELM_TIMEOUT:-5m}"

#########################################################
# Validate Files
#########################################################

echo
echo "Checking deployment files..."

required_files=(
    "${CHART_DIR}/Chart.yaml"
    "${VALUES_FILE}"
    "${RUNTIME_VALUES}"
)

for file in "${required_files[@]}"
do
    if [ ! -f "${file}" ]; then
        echo
        echo "ERROR: Missing file:"
        echo "       ${file}"
        exit 1
    fi
done

echo "Deployment files verified."

#########################################################
# Deploy
#########################################################

echo
echo "Deploying Helm release..."

helm upgrade \
    --install \
    "${RELEASE_NAME}" \
    "${CHART_DIR}" \
    --namespace "${NAMESPACE}" \
    --create-namespace \
    -f "${VALUES_FILE}" \
    -f "${RUNTIME_VALUES}" \
    --wait \
    --timeout "${HELM_TIMEOUT}"

echo
echo "Deployment completed."

#########################################################
# Rollout Status
#########################################################

helm upgrade \
    --install \
    "${RELEASE_NAME}" \
    "${CHART_DIR}" \
    --namespace "${NAMESPACE}" \
    --create-namespace \
    -f "${VALUES_FILE}" \
    -f "${RUNTIME_VALUES}" \
    --wait \
    --timeout "${HELM_TIMEOUT}"

echo
echo "Rollout completed."

#########################################################
# Release Status
#########################################################

echo
echo "========================================"
echo "Release Status"
echo "========================================"

helm status "${RELEASE_NAME}" \
-n "${NAMESPACE}"

#########################################################
# Release History
#########################################################

echo
echo "========================================"
echo "Release History"
echo "========================================"

helm history "${RELEASE_NAME}" \
-n "${NAMESPACE}"

#########################################################
# Current Image
#########################################################

echo
echo "========================================"
echo "Running Image"
echo "========================================"

kubectl get deployment \
"${RELEASE_NAME}" \
-n "${NAMESPACE}" \
-o=jsonpath='{.spec.template.spec.containers[0].image}'

echo
echo

#########################################################
# Success
#########################################################

echo "========================================"
echo "Helm Deployment Successful"
echo "========================================"
