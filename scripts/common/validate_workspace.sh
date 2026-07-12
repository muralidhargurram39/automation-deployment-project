#!/bin/bash

set -euo pipefail

echo "========================================"
echo "Validate Jenkins Workspace"
echo "========================================"

echo
echo "Current directory:"
pwd

echo
echo "Workspace contents:"
ls -la

required_files=(
    Dockerfile
    pom.xml
    target/automation-deployment.war
)

echo
echo "Checking required files..."

for file in "${required_files[@]}"
do
    if [ ! -f "$file" ]; then
        echo
        echo "ERROR: Required file not found:"
        echo "  $file"
        exit 1
    fi

    echo "✓ $file"
done

echo
echo "Git Branch:"
git branch --show-current || true

echo
echo "Git Commit:"
git rev-parse HEAD || true

echo
echo "========================================"
echo "Workspace validation successful."
echo "========================================"
