#!/bin/bash
set -e

# Compute absolute path to repo root
REPO_ROOT="$(cd "$(dirname "$0")/.." && pwd)"

echo "=== Running build ==="
echo "Working directory: $(pwd)"
echo "Repo root: $REPO_ROOT"

# --- Check COSMoS ---
if [ ! -d "$REPO_ROOT/cosmos" ]; then
    echo "ERROR: COSMoS repo not found!"
    exit 1
fi
echo "COSMoS found at: $REPO_ROOT/cosmos"

# --- Check CDISC folder ---
if [ ! -d "$REPO_ROOT/crf_user_guide" ]; then
    echo "ERROR: crf_user_guide folder missing!"
    exit 1
fi

# --- Check SDTM Terminology ---
if [ ! -f "$REPO_ROOT/crf_user_guide/SDTM_Terminology.xlsx" ]; then
    echo "ERROR: SDTM_Terminology.xlsx missing!"
    echo "Run: $REPO_ROOT/scripts/download_cdisc.sh"
    exit 1
fi

# --- Check SDTMIG ---
if [ ! -f "$REPO_ROOT/crf_user_guide/SDTMIG_v3.4.xlsx" ]; then
    echo "ERROR: SDTMIG_v3.4.xlsx missing!"
    echo "Run: $REPO_ROOT/scripts/download_cdisc.sh"
    exit 1
fi

echo "CDISC files found:"
ls -la "$REPO_ROOT/crf_user_guide"

# --- CDISC version logging ---
echo "=== Logging CDISC versions ==="
"$REPO_ROOT/scripts/log_cdisc_versions.sh"

# --- CDISC update detection ---
echo "=== Checking for CDISC updates ==="
if "$REPO_ROOT/scripts/check_cdisc_updates.sh"; then
    echo "No CDISC changes → Skipping embedding + FAISS rebuild."
else
    echo "CDISC changed → Rebuilding embeddings + FAISS index..."
    python3 "$REPO_ROOT/tools/build_embeddings.py"
    python3 "$REPO_ROOT/tools/build_faiss.py"
fi

# --- Generate version.json ---
"$REPO_ROOT/scripts/generate_cdisc_version_json.sh"

echo "=== All prerequisites satisfied ==="
echo "Starting actual build..."

# --- Your build logic here ---
# Example:
# python3 "$REPO_ROOT/tools/build_index.py" --cosmos "$REPO_ROOT/cosmos" --cdisc "$REPO_ROOT/crf_user_guide"

echo "=== Build completed successfully ==="

