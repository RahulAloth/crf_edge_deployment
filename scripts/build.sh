#!/bin/bash
set -e

echo "=== Running build ==="
echo "Working directory: $(pwd)"

# --- Check COSMoS ---
if [ ! -d "cosmos" ]; then
    echo "ERROR: COSMoS repo not found!"
    exit 1
fi
echo "COSMoS found at: $(pwd)/cosmos"

# --- Check CDISC folder ---
if [ ! -d "crf_user_guide" ]; then
    echo "ERROR: crf_user_guide folder missing!"
    exit 1
fi

# --- Check SDTM Terminology ---
if [ ! -f "crf_user_guide/SDTM_Terminology.xlsx" ]; then
    echo "ERROR: SDTM_Terminology.xlsx missing!"
    echo "Run: ./download_cdisc.sh"
    exit 1
fi

# --- Check SDTMIG ---
if [ ! -f "crf_user_guide/SDTMIG_v3.4.xlsx" ]; then
    echo "ERROR: SDTMIG_v3.4.xlsx missing!"
    echo "Run: ./download_cdisc.sh"
    exit 1
fi

echo "CDISC files found:"
ls -la crf_user_guide

echo "=== All prerequisites satisfied ==="
echo "Starting actual build..."

# --- Your build logic here ---
# Example:
# python3 tools/build_index.py --cosmos ./cosmos --cdisc ./crf_user_guide

echo "=== Build completed successfully ==="

