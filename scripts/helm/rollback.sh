#!/bin/bash

set -euo pipefail

echo "========================================"
echo "Helm Rollback"
echo "========================================"

#########################################################
# Configuration
#########################################################

RELEASE_NAME="${RELEASE_NAME:-automation-deployment}"
NAMESPACE="${K8S_NAMESPACE:-automation-deployment}"

#########################################################
# Validate Input
#########################################################

if [ $# -ne 1 ]; then
    echo
    echo "Usage:"
    echo "./rollback.sh <revision>"
    exit 1
fi

REVISION="$1"

#########################################################
# Current History
#########################################################

echo
echo "Current Release History"

helm history \
"${RELEASE_NAME}" \
-n "${NAMESPACE}"

#########################################################
# Rollback
#########################################################

echo
echo "Rolling back to revision ${REVISION}..."

helm rollback \
"${RELEASE_NAME}" \
"${REVISION}" \
-n "${NAMESPACE}" \
--wait \
--timeout 5m

#########################################################
# Wait
#########################################################

echo
echo "Waiting for rollout..."

kubectl rollout status \
deployment/"${RELEASE_NAME}" \
-n "${NAMESPACE}" \
--timeout=300s

#########################################################
# Verify
#########################################################

echo
echo "Rollback completed."

helm status \
"${RELEASE_NAME}" \
-n "${NAMESPACE}"

#########################################################
# Running Image
#########################################################

echo
echo "Running Image"

kubectl get deployment \
"${RELEASE_NAME}" \
-n "${NAMESPACE}" \
-o=jsonpath='{.spec.template.spec.containers[0].image}'

echo
echo

#########################################################
# History
#########################################################

echo
echo "Updated History"

helm history \
"${RELEASE_NAME}" \
-n "${NAMESPACE}"

#########################################################
# Completed
#########################################################

echo
echo "========================================"
echo "Rollback Successful"
echo "========================================"
