#!/bin/bash
set -e

# Compute absolute path to repo root
REPO_ROOT="$(cd "$(dirname "$0")/.." && pwd)"

CDISC_DIR="$REPO_ROOT/crf_user_guide"
CHECKSUM_FILE="$REPO_ROOT/metadata/cdisc_checksums.json"

mkdir -p "$REPO_ROOT/metadata"

TERMINOLOGY="$CDISC_DIR/SDTM_Terminology.xlsx"
SDTMIG="$CDISC_DIR/SDTMIG_v3.4.xlsx"

# Ensure CDISC files exist
if [ ! -f "$TERMINOLOGY" ]; then
    echo "ERROR: Missing file: $TERMINOLOGY"
    exit 1
fi

if [ ! -f "$SDTMIG" ]; then
    echo "ERROR: Missing file: $SDTMIG"
    exit 1
fi

# Generate new checksums
NEW_TERMINOLOGY_SHA=$(sha256sum "$TERMINOLOGY" | awk '{print $1}')
NEW_SDTMIG_SHA=$(sha256sum "$SDTMIG" | awk '{print $1}')

NEW_JSON=$(cat <<EOF
{
  "terminology_sha": "$NEW_TERMINOLOGY_SHA",
  "sdtmig_sha": "$NEW_SDTMIG_SHA"
}
EOF
)

# If no previous checksum file exists → treat as changed
if [ ! -f "$CHECKSUM_FILE" ]; then
    echo "No previous checksum file found. CDISC update detected."
    echo "$NEW_JSON" > "$CHECKSUM_FILE"
    exit 1
fi

OLD_JSON=$(cat "$CHECKSUM_FILE")

# Compare old vs new
if [ "$NEW_JSON" == "$OLD_JSON" ]; then
    echo "No CDISC changes detected."
    exit 0
else
    echo "CDISC update detected!"
    echo "$NEW_JSON" > "$CHECKSUM_FILE"
    exit 1
fi

