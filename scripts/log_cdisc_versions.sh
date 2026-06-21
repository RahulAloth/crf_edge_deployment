#!/bin/bash
set -e

echo "=== CDISC Version Logging ==="

# Compute absolute path to repo root
REPO_ROOT="$(cd "$(dirname "$0")/.." && pwd)"
CDISC_DIR="$REPO_ROOT/crf_user_guide"

# --- Check folder ---
if [ ! -d "$CDISC_DIR" ]; then
    echo "ERROR: CDISC folder missing at $CDISC_DIR"
    exit 1
fi

# --- Log function ---
log_file_info() {
    local file=$1

    if [ ! -f "$file" ]; then
        echo "ERROR: Missing file: $file"
        return
    fi

    echo ""
    echo "File: $file"
    echo "Size: $(stat -c%s "$file") bytes"
    echo "Modified: $(stat -c%y "$file")"
    echo "SHA256: $(sha256sum "$file" | awk '{print $1}')"

    # Extract version from filename if present
    if [[ "$file" =~ ([0-9]+\.[0-9]+) ]]; then
        echo "Detected Version: ${BASH_REMATCH[1]}"
    fi
}

# --- Log SDTM Terminology ---
log_file_info "$CDISC_DIR/SDTM_Terminology.xlsx"

# --- Log SDTMIG ---
log_file_info "$CDISC_DIR/SDTMIG_v3.4.xlsx"

echo ""
echo "=== CDISC Version Logging Completed ==="

