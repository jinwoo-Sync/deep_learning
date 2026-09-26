#!/usr/bin/env bash
# User runs this after accepting the gated model terms and `hf auth login`.
# TensorGraphX requires the HF ViT-B/16 snapshot directory, not a raw .pth file.
set -euo pipefail
ROOT="$(cd "$(dirname "$0")/.." && pwd)"
DST="$ROOT/model_weights/dinov3/vitb16-hf"
mkdir -p "$DST"
uvx --from huggingface_hub hf download facebook/dinov3-vitb16-pretrain-lvd1689m --local-dir "$DST"
test -s "$DST/config.json"
test -s "$DST/model.safetensors"
printf 'DINOv3 local model directory: %s\n' "$DST"
