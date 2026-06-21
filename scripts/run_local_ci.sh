#!/bin/bash
set -e

# Compute absolute path to repo root
REPO_ROOT="$(cd "$(dirname "$0")/.." && pwd)"

echo "=== Local CI Started ==="
echo "Working directory: $(pwd)"
echo "Repo root: $REPO_ROOT"

echo "=== Downloading CDISC Files ==="
"$REPO_ROOT/scripts/download_cdisc.sh"

echo "=== Cloning COSMoS ==="
rm -rf "$REPO_ROOT/cosmos"
git clone https://github.com/RahulAloth/COSMoS.git "$REPO_ROOT/cosmos"

echo "=== Running Build ==="
"$REPO_ROOT/scripts/build.sh"

echo "=== Running Tests ==="
"$REPO_ROOT/scripts/test.sh"

echo "=== Running Deploy ==="
"$REPO_ROOT/scripts/deploy.sh"

echo "=== Local CI Completed Successfully ==="

