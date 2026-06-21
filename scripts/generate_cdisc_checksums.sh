#!/bin/bash
set -e

# Compute absolute path to repo root
REPO_ROOT="$(cd "$(dirname "$0")/.." && pwd)"

CDISC_DIR="$REPO_ROOT/crf_user_guide"

TERMINOLOGY="$CDISC_DIR/SDTM_Terminology.xlsx"
SDTMIG="$CDISC_DIR/SDTMIG_v3.4.xlsx"

echo "{
  \"terminology_sha\": \"$(sha256sum "$TERMINOLOGY" | awk '{print $1}')\",
  \"sdtmig_sha\": \"$(sha256sum "$SDTMIG" | awk '{print $1}')\"
}"

