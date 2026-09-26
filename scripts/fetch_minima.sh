#!/usr/bin/env bash
# Official MINIMA LoFTR and XoFTR checkpoints for TensorGraphX matchers.
# Run this yourself; no Python environment is installed by this script.
set -euo pipefail
ROOT="$(cd "$(dirname "$0")/.." && pwd)"
DST="$ROOT/model_weights/minima"
mkdir -p "$DST"
BASE="https://github.com/LSXI7/storage/releases/download/MINIMA"
curl -fL --retry 3 --progress-bar -o "$DST/minima_loftr.ckpt" "$BASE/minima_loftr.ckpt"
curl -fL --retry 3 --progress-bar -o "$DST/minima_xoftr.ckpt" "$BASE/minima_xoftr.ckpt"
ls -lh "$DST"
