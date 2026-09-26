#!/usr/bin/env bash
# Fetch every selected checkpoint. Source-only ELSED needs no weight.
# DeepLSD, DiffusionEdge, LightGlue and OmniGlue are excluded.
# This script never installs a Python project or modifies an existing venv.
set -euo pipefail
ROOT="$(cd "$(dirname "$0")/.." && pwd)"
W="$ROOT/model_weights"
test -s "$W/dinov3/vitb16-hf/model.safetensors" || "$ROOT/scripts/fetch_dinov3.sh"
test -s "$W/depth_anything_v2/depth_anything_v2_vits.pth" || "$ROOT/scripts/fetch_depth_anything_v2.sh"
test -s "$W/minima/minima_loftr.ckpt" && test -s "$W/minima/minima_xoftr.ckpt" || "$ROOT/scripts/fetch_minima.sh"
test -s "$W/dad/dad.pth" || "$ROOT/scripts/fetch_dad.sh"
test -s "$W/dedode/dedode_detector_L_v2.pth" || "$ROOT/scripts/fetch_dedode.sh"
test -s "$W/linea/linea_hgnetv2_l.pth" || "$ROOT/scripts/fetch_linea.sh"
test -s "$W/map_anything/model.safetensors" || "$ROOT/scripts/fetch_map_anything.sh"
test -s "$W/xoftr/weights_xoftr_640.ckpt" && test -s "$W/xoftr/weights_xoftr_840.ckpt" || "$ROOT/scripts/fetch_xoftr.sh"
test -s "$W/sam2/sam2.1_hiera_small.pt" || "$ROOT/scripts/fetch_sam2.sh"
echo "Selected weights are present under: $W"
