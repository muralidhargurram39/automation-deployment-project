#!/bin/bash

set -e

echo "========================================"
echo "Security Gate"
echo "========================================"

REPORT="reports/image/trivy.json"

if [ ! -f "$REPORT" ]; then
    echo "ERROR: $REPORT not found."
    exit 1
fi

FAIL_ON_CRITICAL=${FAIL_ON_CRITICAL:-true}
FAIL_ON_HIGH=${FAIL_ON_HIGH:-false}

CRITICAL=$(jq '[.. | objects | select(.Severity?=="CRITICAL")] | length' "$REPORT")
HIGH=$(jq '[.. | objects | select(.Severity?=="HIGH")] | length' "$REPORT")
MEDIUM=$(jq '[.. | objects | select(.Severity?=="MEDIUM")] | length' "$REPORT")
LOW=$(jq '[.. | objects | select(.Severity?=="LOW")] | length' "$REPORT")

echo
echo "========================================"
echo "Security Summary"
echo "========================================"

echo "Critical : $CRITICAL"
echo "High     : $HIGH"
echo "Medium   : $MEDIUM"
echo "Low      : $LOW"

echo

if [ "$FAIL_ON_CRITICAL" = "true" ] && [ "$CRITICAL" -gt 0 ]; then
    echo "Build failed due to CRITICAL vulnerabilities."
    exit 1
fi

if [ "$FAIL_ON_HIGH" = "true" ] && [ "$HIGH" -gt 0 ]; then
    echo "Build failed due to HIGH vulnerabilities."
    exit 1
fi

echo "Security Gate PASSED"
