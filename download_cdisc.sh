#!/bin/bash
set -e

echo "=== CDISC Downloader Started ==="
echo "Working directory: $(pwd)"

# Create folder if not exists
mkdir -p crf_user_guide

echo "=== Downloading SDTM Terminology (latest) ==="
curl -L -o crf_user_guide/SDTM_Terminology.xlsx \
  "https://evs.nci.nih.gov/ftp1/CDISC/SDTM/SDTM%20Terminology.xlsx"

echo "=== Downloading SDTMIG v3.4 (Excel) ==="
curl -L -o crf_user_guide/SDTMIG_v3.4.xlsx \
  "https://www.cdisc.org/system/files/members/standard/foundational/sdtmig/sdtmig-3-4.xlsx"

echo "=== Download Completed ==="
ls -la crf_user_guide

