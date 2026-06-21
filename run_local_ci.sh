#!/bin/bash
set -e

echo "=== Local CI Started ==="
echo "Working directory: $(pwd)"

echo "=== Cloning COSMoS ==="
rm -rf cosmos
git clone https://github.com/RahulAloth/COSMoS.git cosmos

echo "=== Running Build ==="
./scripts/build.sh

echo "=== Running Tests ==="
./scripts/test.sh

echo "=== Running Deploy ==="
./scripts/deploy.sh

echo "=== Local CI Completed Successfully ==="

