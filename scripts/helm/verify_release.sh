#!/bin/bash

set -euo pipefail

echo "========================================"
echo "Verify Helm Release"
echo "========================================"

#########################################################
# Configuration
#########################################################

RELEASE_NAME="${RELEASE_NAME:-automation-deployment}"
NAMESPACE="${K8S_NAMESPACE:-automation-deployment}"
SERVICE_NAME="${SERVICE_NAME:-automation-service}"

#########################################################
# Verify Release Exists
#########################################################

echo
echo "Checking Helm release..."

helm status "${RELEASE_NAME}" \
    -n "${NAMESPACE}"

echo
echo "Helm release exists."

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
# Rollout Status
#########################################################

echo
echo "========================================"
echo "Deployment Status"
echo "========================================"

kubectl rollout status \
deployment/"${RELEASE_NAME}" \
-n "${NAMESPACE}" \
--timeout=300s

#########################################################
# Pods
#########################################################

echo
echo "========================================"
echo "Pods"
echo "========================================"

kubectl get pods \
-n "${NAMESPACE}" \
-o wide

#########################################################
# Services
#########################################################

echo
echo "========================================"
echo "Services"
echo "========================================"

kubectl get svc \
-n "${NAMESPACE}"

#########################################################
# Ingress (optional)
#########################################################

echo
echo "========================================"
echo "Ingress"
echo "========================================"

kubectl get ingress \
-n "${NAMESPACE}" || true

#########################################################
# HPA (optional)
#########################################################

echo
echo "========================================"
echo "Horizontal Pod Autoscaler"
echo "========================================"

kubectl get hpa \
-n "${NAMESPACE}" || true

#########################################################
# Running Image
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
# Smoke Test
#########################################################

echo
echo "========================================"
echo "Application Smoke Test"
echo "========================================"

LOCAL_PORT="${LOCAL_PORT:-8088}"

echo
echo "Starting temporary port-forward..."

kubectl port-forward \
service/"${SERVICE_NAME}" \
${LOCAL_PORT}:80 \
-n "${NAMESPACE}" \
>/tmp/port-forward.log 2>&1 &

PORT_FORWARD_PID=$!

#########################################################
# Cleanup Function
#########################################################

cleanup() {
    if ps -p ${PORT_FORWARD_PID} >/dev/null 2>&1; then
        kill ${PORT_FORWARD_PID} >/dev/null 2>&1 || true
        wait ${PORT_FORWARD_PID} 2>/dev/null || true
    fi
}

trap cleanup EXIT

#########################################################
# Wait until Port Forward is Ready
#########################################################

echo
echo "Waiting for port-forward..."

for i in {1..10}
do
    if curl -s http://localhost:${LOCAL_PORT}/ >/dev/null 2>&1
    then
        break
    fi

    sleep 1
done

#########################################################
# HTTP Smoke Test
#########################################################

HTTP_CODE=$(curl \
    --silent \
    --output /dev/null \
    --write-out "%{http_code}" \
    http://localhost:${LOCAL_PORT}/ || true)

echo
echo "HTTP Status : ${HTTP_CODE}"

if [ "${HTTP_CODE}" != "200" ]
then
    echo
    echo "ERROR: Smoke test FAILED."
    echo
    echo "Port-forward log:"
    cat /tmp/port-forward.log || true
    exit 1
fi

echo
echo "Smoke test PASSED."

#########################################################
# Summary
#########################################################

echo
echo "========================================"
echo "Helm Release Verification PASSED"
echo "========================================"
