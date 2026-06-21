#!/bin/bash
set -e

# Compute absolute path to repo root
REPO_ROOT="$(cd "$(dirname "$0")/.." && pwd)"

echo "=== Running deploy ==="
echo "Working directory: $(pwd)"
echo "Repo root: $REPO_ROOT"

# --- Check COSMoS ---
if [ ! -d "$REPO_ROOT/cosmos" ]; then
    echo "ERROR: COSMoS repo missing during deploy!"
    exit 1
fi

# --- Check CDISC folder ---
if [ ! -d "$REPO_ROOT/crf_user_guide" ]; then
    echo "ERROR: crf_user_guide folder missing during deploy!"
    exit 1
fi

echo "=== Deploying application ==="

# --- Your deploy logic here ---
# Example:
# scp -r "$REPO_ROOT/output/" user@server:/opt/crf_edge/

echo "=== Deploy completed successfully ==="

