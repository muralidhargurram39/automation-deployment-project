#!/bin/bash

set -euo pipefail

############################################################
# Kubernetes Deployment Diagnostics
############################################################

DIAGNOSTICS_DIR="diagnostics"
TIMESTAMP=$(date +"%Y%m%d_%H%M%S")

mkdir -p "${DIAGNOSTICS_DIR}"

echo "========================================"
echo " Kubernetes Deployment Diagnostics"
echo "========================================"

required_vars=(
    K8S_NAMESPACE
    DEPLOYMENT_NAME
)

for var in "${required_vars[@]}"
do
    if [ -z "${!var:-}" ]; then
        echo "ERROR: Environment variable '$var' is not set."
        exit 1
    fi
done

echo
echo "Namespace  : ${K8S_NAMESPACE}"
echo "Deployment : ${DEPLOYMENT_NAME}"
echo "Timestamp  : ${TIMESTAMP}"

############################################################
save_output() {

    local title="$1"
    local outfile="$2"

    shift 2

    echo
    echo "========================================"
    echo "${title}"
    echo "========================================"

    "$@" > "${DIAGNOSTICS_DIR}/${outfile}" 2>&1 || true

    cat "${DIAGNOSTICS_DIR}/${outfile}"
}

############################################################

save_output \
"Cluster Nodes" \
"nodes.txt" \
kubectl get nodes -o wide

############################################################

echo
echo "========================================"
echo "Node Resource Usage"
echo "========================================"

kubectl top nodes \
> "${DIAGNOSTICS_DIR}/node-top.txt" 2>&1 || \
echo "Metrics Server not installed." \
> "${DIAGNOSTICS_DIR}/node-top.txt"

cat "${DIAGNOSTICS_DIR}/node-top.txt"

############################################################

echo
echo "========================================"
echo "Pod Resource Usage"
echo "========================================"

kubectl top pods \
-n "${K8S_NAMESPACE}" \
> "${DIAGNOSTICS_DIR}/pod-top.txt" 2>&1 || \
echo "Metrics Server not installed." \
> "${DIAGNOSTICS_DIR}/pod-top.txt"

cat "${DIAGNOSTICS_DIR}/pod-top.txt"

############################################################

save_output \
"Deployment Status" \
"deployment.txt" \
kubectl get deployment \
"${DEPLOYMENT_NAME}" \
-n "${K8S_NAMESPACE}" \
-o wide

############################################################

save_output \
"ReplicaSets" \
"replicasets.txt" \
kubectl get rs \
-n "${K8S_NAMESPACE}" \
-o wide

############################################################

save_output \
"Pods" \
"pods.txt" \
kubectl get pods \
-n "${K8S_NAMESPACE}" \
-o wide

############################################################

save_output \
"Services" \
"services.txt" \
kubectl get svc \
-n "${K8S_NAMESPACE}"

############################################################

save_output \
"Endpoints" \
"endpoints.txt" \
kubectl get endpoints \
-n "${K8S_NAMESPACE}"

############################################################

save_output \
"Deployment Description" \
"deployment-describe.txt" \
kubectl describe deployment \
"${DEPLOYMENT_NAME}" \
-n "${K8S_NAMESPACE}"

############################################################

save_output \
"Cluster Events" \
"events.txt" \
kubectl get events \
-n "${K8S_NAMESPACE}" \
--sort-by=.lastTimestamp

############################################################

echo
echo "========================================"
echo "Pod Diagnostics"
echo "========================================"

PODS=$(kubectl get pods \
-n "${K8S_NAMESPACE}" \
-o jsonpath='{.items[*].metadata.name}')

for POD in ${PODS}
do

    STATUS=$(kubectl get pod \
        "${POD}" \
        -n "${K8S_NAMESPACE}" \
        -o jsonpath='{.status.phase}')

    READY=$(kubectl get pod \
        "${POD}" \
        -n "${K8S_NAMESPACE}" \
        -o jsonpath='{.status.containerStatuses[0].ready}')

    echo
    echo "----------------------------------------"
    echo "Pod : ${POD}"
    echo "----------------------------------------"

    kubectl describe pod \
        "${POD}" \
        -n "${K8S_NAMESPACE}" \
        > "${DIAGNOSTICS_DIR}/${POD}.describe.txt" 2>&1 || true

    cat "${DIAGNOSTICS_DIR}/${POD}.describe.txt"

    if [[ "${STATUS}" != "Running" || "${READY}" != "true" ]]
    then

        echo
        echo "Recent Logs"

        kubectl logs \
            "${POD}" \
            -n "${K8S_NAMESPACE}" \
            --tail=200 \
            > "${DIAGNOSTICS_DIR}/${POD}.logs.txt" 2>&1 || true

        cat "${DIAGNOSTICS_DIR}/${POD}.logs.txt"

        echo
        echo "Previous Logs"

        kubectl logs \
            "${POD}" \
            -n "${K8S_NAMESPACE}" \
            --previous \
            --tail=200 \
            > "${DIAGNOSTICS_DIR}/${POD}.previous.txt" 2>&1 || true

        cat "${DIAGNOSTICS_DIR}/${POD}.previous.txt"

    fi

done

############################################################

echo
echo "========================================"
echo "Diagnostics Directory"
echo "========================================"

ls -lh "${DIAGNOSTICS_DIR}"

echo
echo "========================================"
echo "Diagnostics Collection Complete"
echo "========================================"
