#!/usr/bin/env bash
# DeepLSD official pretrained checkpoints; md is preferred for outdoor images.
set -euo pipefail
ROOT="$(cd "$(dirname "$0")/.." && pwd)"
DST="$ROOT/model_weights/deeplsd"
mkdir -p "$DST"
curl -fL --retry 3 --progress-bar -o "$DST/deeplsd_md.tar" "https://cvg-data.inf.ethz.ch/DeepLSD/deeplsd_md.tar"
if [[ "${1:-}" == "--all" ]]; then
  curl -fL --retry 3 --progress-bar -o "$DST/deeplsd_wireframe.tar" "https://cvg-data.inf.ethz.ch/DeepLSD/deeplsd_wireframe.tar"
fi
ls -lh "$DST"
