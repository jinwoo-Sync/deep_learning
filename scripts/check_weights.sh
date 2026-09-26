#!/usr/bin/env bash
# Read-only, portable presence and size check. No model environment required.
set -euo pipefail
ROOT="$(cd "$(dirname "$0")/.." && pwd)"
W="$ROOT/model_weights"
missing=0
check() {
  local path="$1"
  if test -s "$W/$path"; then
    printf 'OK      %10s bytes  %s\n' "$(wc -c < "$W/$path" | tr -d ' ')" "$path"
  else
    printf 'MISSING %10s        %s\n' '-' "$path"
    missing=1
  fi
}
check dinov2_vits14_pretrain.pth
check dinov3/vitb16-hf/config.json
check dinov3/vitb16-hf/model.safetensors
check dad/dad.pth
check dedode/dedode_detector_L_v2.pth
check minima/minima_loftr.ckpt
check minima/minima_xoftr.ckpt
check xoftr/weights_xoftr_640.ckpt
check xoftr/weights_xoftr_840.ckpt
check linea/linea_hgnetv2_l.pth
check depth_anything_v2/depth_anything_v2_vits.pth
check map_anything/config.json
check map_anything/model.safetensors
check sam2/sam2.1_hiera_small.pt
exit "$missing"
