#!/bin/bash
set -e

echo "=== Running deploy ==="
echo "Working directory: $(pwd)"

# --- Check build artifacts or prerequisites ---
if [ ! -d "cosmos" ]; then
    echo "ERROR: COSMoS repo missing during deploy!"
    exit 1
fi

if [ ! -d "crf_user_guide" ]; then
    echo "ERROR: crf_user_guide folder missing during deploy!"
    exit 1
fi

echo "=== Deploying application ==="

# --- Your deploy logic here ---
# Example:
# scp -r output/ user@server:/opt/crf_edge/

echo "=== Deploy completed successfully ==="

