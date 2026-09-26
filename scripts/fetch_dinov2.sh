#!/usr/bin/env bash
# Official DINOv2 ViT-S/14. Useful if Git LFS was unavailable on clone.
set -euo pipefail
ROOT="$(cd "$(dirname "$0")/.." && pwd)"
DST="$ROOT/model_weights/dinov2_vits14_pretrain.pth"
if test -f "$DST" && test "$(wc -c < "$DST")" -eq 88283115; then
  echo "Already present: $DST"
  exit 0
fi
curl -fL --retry 3 --progress-bar -o "$DST.part" \
  https://dl.fbaipublicfiles.com/dinov2/dinov2_vits14/dinov2_vits14_pretrain.pth
mv "$DST.part" "$DST"
ls -lh "$DST"
