#!/bin/bash

set -e

echo "========================================"
echo "Trivy Filesystem Scan"
echo "========================================"

mkdir -p reports

echo
echo "Scanning project source..."

trivy fs \
    --format table \
    --output reports/filesystem/trivy.txt \
    .
trivy fs \
    --format json \
    --output reports/filesystem/trivy.json \
    .
trivy fs \
    --format sarif \
    --output reports/filesystem/trivy.sarif \
    .
trivy fs \
    --format template \
    --template "@scripts/security/templates/html.tpl" \
    --output reports/filesystem/trivy.html \
    .

echo
echo "Filesystem scan completed."

echo
echo "Summary"

trivy fs \
    --severity HIGH,CRITICAL \
    .
