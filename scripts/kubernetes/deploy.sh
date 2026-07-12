#!/bin/bash

set -euo pipefail

echo "Checking prerequisites..."

for cmd in kubectl yq docker kind
do
    if ! command -v "$cmd" >/dev/null 2>&1; then
        echo "ERROR: Required command '$cmd' is not installed."
        exit 1
    fi
done

echo "All prerequisites satisfied."
echo

echo "========================================"
echo "Deploy to Kubernetes"
echo "========================================"

required_vars=(
    DOCKER_REGISTRY
    DOCKER_REPOSITORY
    IMAGE_NAME
    VERSION
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

IMAGE="${DOCKER_REGISTRY}/${DOCKER_REPOSITORY}/${IMAGE_NAME}:${VERSION}"

echo
echo "Namespace  : ${K8S_NAMESPACE}"
echo "Deployment : ${DEPLOYMENT_NAME}"
echo "Image      : ${IMAGE}"

echo
echo "========================================"
echo "Generating Kubernetes Deployment"
echo "========================================"

cp k8s/deployment-template.yaml \
   k8s/deployment.yaml

IMAGE="${IMAGE}" \
yq -i '
.spec.template.spec.containers[0].image = env(IMAGE)
' k8s/deployment.yaml

echo
echo "Generated Deployment Image"

grep "image:" k8s/deployment.yaml

echo
echo "========================================"
echo "Validating Deployment Manifest"
echo "========================================"

kubectl apply \
    --dry-run=client \
    -f k8s/deployment.yaml

echo
echo "========================================"
echo "Applying Kubernetes Resources"
echo "========================================"

echo
echo "Applying Namespace..."
kubectl apply -f k8s/namespace.yaml

echo
echo "Applying ConfigMap..."
kubectl apply -f k8s/configmap.yaml

echo
echo "Applying Secret..."
kubectl apply -f k8s/secret.yaml

echo
echo "Applying Deployment..."
kubectl apply -f k8s/deployment.yaml

echo
echo "Applying Service..."
kubectl apply -f k8s/service.yaml

echo
echo "Restarting Deployment..."

kubectl rollout restart \
deployment/"${DEPLOYMENT_NAME}" \
-n "${K8S_NAMESPACE}"

echo
echo "Waiting for deployment rollout..."

kubectl rollout status \
deployment/"${DEPLOYMENT_NAME}" \
-n "${K8S_NAMESPACE}" \
--timeout=180s


sleep 5

echo
echo "========================================"
echo "Deployment submitted successfully."
echo "========================================"
