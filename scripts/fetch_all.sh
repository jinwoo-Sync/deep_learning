#!/usr/bin/env bash
# Fetch every selected checkpoint. Source-only ELSED needs no weight.
# DeepLSD, DiffusionEdge, LightGlue and OmniGlue are excluded.
# This script never installs a Python project or modifies an existing venv.
set -euo pipefail
ROOT="$(cd "$(dirname "$0")/.." && pwd)"
W="$ROOT/model_weights"
ready() {
  test -f "$1" && test "$(wc -c < "$1")" -ge "$2"
}
ready "$W/dinov2_vits14_pretrain.pth" 88000000 || "$ROOT/scripts/fetch_dinov2.sh"
ready "$W/dinov3/vitb16-hf/model.safetensors" 340000000 || "$ROOT/scripts/fetch_dinov3.sh"
ready "$W/depth_anything_v2/depth_anything_v2_vits.pth" 99000000 || "$ROOT/scripts/fetch_depth_anything_v2.sh"
ready "$W/minima/minima_loftr.ckpt" 46000000 && ready "$W/minima/minima_xoftr.ckpt" 44000000 || "$ROOT/scripts/fetch_minima.sh"
ready "$W/dad/dad.pth" 26000000 || "$ROOT/scripts/fetch_dad.sh"
ready "$W/dedode/dedode_detector_L_v2.pth" 58000000 || "$ROOT/scripts/fetch_dedode.sh"
ready "$W/linea/linea_hgnetv2_l.pth" 104000000 || "$ROOT/scripts/fetch_linea.sh"
ready "$W/map_anything/model.safetensors" 4914000000 || "$ROOT/scripts/fetch_map_anything.sh"
ready "$W/xoftr/weights_xoftr_640.ckpt" 44000000 && ready "$W/xoftr/weights_xoftr_840.ckpt" 44000000 || "$ROOT/scripts/fetch_xoftr.sh"
ready "$W/sam2/sam2.1_hiera_small.pt" 184000000 || "$ROOT/scripts/fetch_sam2.sh"
echo "Selected weights are present under: $W"
