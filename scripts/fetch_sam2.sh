#!/usr/bin/env bash
# Official SAM 2.1 Hiera Small checkpoint. No Python environment changes.
set -euo pipefail
ROOT="$(cd "$(dirname "$0")/.." && pwd)"
DST="$ROOT/model_weights/sam2"
mkdir -p "$DST"
if test -s "$DST/sam2.1_hiera_small.pt"; then
  echo "Already present: $DST/sam2.1_hiera_small.pt"
  exit 0
fi
curl -fL --retry 3 --progress-bar -o "$DST/sam2.1_hiera_small.pt.part" \
  https://dl.fbaipublicfiles.com/segment_anything_2/092824/sam2.1_hiera_small.pt
mv "$DST/sam2.1_hiera_small.pt.part" "$DST/sam2.1_hiera_small.pt"
ls -lh "$DST/sam2.1_hiera_small.pt"
