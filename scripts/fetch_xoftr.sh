#!/usr/bin/env bash
# Official XoFTR checkpoints from the authors' Google Drive folder.
set -euo pipefail
ROOT="$(cd "$(dirname "$0")/.." && pwd)"
DST="$ROOT/model_weights/xoftr"
mkdir -p "$DST"
if test -s "$DST/weights_xoftr_640.ckpt" && test -s "$DST/weights_xoftr_840.ckpt"; then
  echo "Already present: XoFTR 640 and 840"
  exit 0
fi
uvx --from gdown gdown --folder \
  https://drive.google.com/drive/folders/1RAI243OHuyZ4Weo1NiTy280bCE_82s4q \
  -O "$DST"
test -s "$DST/weights_xoftr_640.ckpt"
test -s "$DST/weights_xoftr_840.ckpt"
ls -lh "$DST"/*.ckpt
