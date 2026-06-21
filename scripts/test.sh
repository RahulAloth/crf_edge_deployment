#!/bin/bash
set -e

echo "=== Running tests ==="
echo "Working directory: $(pwd)"

if [ ! -d "cosmos" ]; then
    echo "ERROR: COSMoS repo missing!"
    exit 1
fi

# Your test logic here

