#!/bin/bash
set -e

# Compute absolute path to repo root
REPO_ROOT="$(cd "$(dirname "$0")/.." && pwd)"

CDISC_DIR="$REPO_ROOT/crf_user_guide"
OUTPUT_FILE="$REPO_ROOT/metadata/cdisc_version.json"

mkdir -p "$REPO_ROOT/metadata"

TERMINOLOGY="$CDISC_DIR/SDTM_Terminology.xlsx"
SDTMIG="$CDISC_DIR/SDTMIG_v3.4.xlsx"

# Extract version from filename (e.g., 3.4)
extract_version() {
    if [[ "$1" =~ ([0-9]+\.[0-9]+) ]]; then
        echo "${BASH_REMATCH[1]}"
    else
        echo "unknown"
    fi
}

TERMINOLOGY_SHA=$(sha256sum "$TERMINOLOGY" | awk '{print $1}')
SDTMIG_SHA=$(sha256sum "$SDTMIG" | awk '{print $1}')

TERMINOLOGY_SIZE=$(stat -c%s "$TERMINOLOGY")
SDTMIG_SIZE=$(stat -c%s "$SDTMIG")

TERMINOLOGY_MOD=$(stat -c%y "$TERMINOLOGY")
SDTMIG_MOD=$(stat -c%y "$SDTMIG")

SDTMIG_VERSION=$(extract_version "$SDTMIG")

RUN_TIMESTAMP=$(date -u +"%Y-%m-%dT%H:%M:%SZ")

cat <<EOF > "$OUTPUT_FILE"
{
  "generated_at": "$RUN_TIMESTAMP",
  "files": {
    "SDTM_Terminology.xlsx": {
      "sha256": "$TERMINOLOGY_SHA",
      "size_bytes": $TERMINOLOGY_SIZE,
      "last_modified": "$TERMINOLOGY_MOD"
    },
    "SDTMIG_v3.4.xlsx": {
      "sha256": "$SDTMIG_SHA",
      "size_bytes": $SDTMIG_SIZE,
      "last_modified": "$SDTMIG_MOD",
      "version": "$SDTMIG_VERSION"
    }
  }
}
EOF

echo "CDISC version.json generated at: $OUTPUT_FILE"

