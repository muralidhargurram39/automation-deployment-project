#!/bin/bash

set -euo pipefail

echo "========================================"
echo "Validate Helm Chart"
echo "========================================"

#########################################################
# Configuration
#########################################################

CHART_DIR="${CHART_DIR:-helm/automation-deployment}"

VALUES_FILE="${VALUES_FILE:-${CHART_DIR}/values.yaml}"

RUNTIME_VALUES="${RUNTIME_VALUES:-target/runtime-values.yaml}"

RELEASE_NAME="${RELEASE_NAME:-automation-deployment}"

NAMESPACE="${K8S_NAMESPACE:-automation-deployment}"

#########################################################
# Validate Required Files
#########################################################

echo
echo "Checking Helm chart files..."

required_files=(
    "${CHART_DIR}/Chart.yaml"
    "${VALUES_FILE}"
    "${RUNTIME_VALUES}"
)

for file in "${required_files[@]}"
do
    if [ ! -f "${file}" ]; then
        echo
        echo "ERROR: Required file not found:"
        echo "       ${file}"
        exit 1
    fi
done

echo "All required files found."

#########################################################
# Helm Lint
#########################################################

echo
echo "Running helm lint..."

helm lint "${CHART_DIR}"

echo
echo "Helm lint PASSED."

#########################################################
# Helm Template
#########################################################

echo
echo "Rendering Helm templates..."

helm template automation-deployment \
    "${CHART_DIR}" \
    -f "${VALUES_FILE}" \
    -f "${RUNTIME_VALUES}" \
    >/dev/null

echo
echo "Template rendering PASSED."

#########################################################
# Dry Run Upgrade
#########################################################

echo
echo "Running Helm dry-run deployment..."

helm upgrade \
    --install \
    automation-deployment \
    "${CHART_DIR}" \
    --namespace automation-deployment \
    --create-namespace \
    --dry-run \
    -f "${VALUES_FILE}" \
    -f "${RUNTIME_VALUES}" \
    >/dev/null

echo
echo "Dry-run deployment PASSED."

#########################################################
# Summary
#########################################################

echo
echo "========================================"
echo "Helm Chart Validation PASSED"
echo "========================================"
