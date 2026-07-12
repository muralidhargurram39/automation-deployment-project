#!/bin/bash

set -euo pipefail

collect_failure() {

    echo
    echo "========================================"
    echo " Deployment Failed"
    echo " Collecting Diagnostics"
    echo "========================================"

    ./scripts/kubernetes/collect_diagnostics.sh || true
}

trap collect_failure ERR

echo "======================================================="
echo " Kubernetes Deployment Pipeline"
echo "======================================================="

#########################################################
echo
echo "Step 1/6 : Verify Image in Nexus"

./scripts/kubernetes/check_registry.sh

#########################################################
echo
echo "Step 2/6 : Load Image into Kind"

./scripts/kubernetes/load_image.sh

#########################################################
echo
echo "Step 3/6 : Deploy to Kubernetes"

./scripts/kubernetes/deploy.sh

#########################################################
echo
echo "Step 4/6 : Verify Deployment"

./scripts/kubernetes/verify.sh

#########################################################
echo
echo "Step 5/6 : Smoke Test"

./scripts/kubernetes/smoke_test.sh

#########################################################
echo
echo "Step 6/6 : Collect Final Diagnostics"

./scripts/kubernetes/collect_diagnostics.sh

trap - ERR

echo
echo "======================================================="
echo " Kubernetes Deployment Successful"
echo "======================================================="
