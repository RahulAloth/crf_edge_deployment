#!/bin/bash
set -e

echo "=== Running build ==="
echo "Working directory: $(pwd)"

if [ ! -d "cosmos" ]; then
    echo "ERROR: COSMoS repo not found!"
    exit 1
fi

echo "COSMoS found at: $(pwd)/cosmos"
# Your build logic here

