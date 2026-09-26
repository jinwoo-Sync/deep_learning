#!/usr/bin/env bash
# Official Kornia HF mirror; --all adds comparison checkpoints.
set -euo pipefail
ROOT="$(cd "$(dirname "$0")/.." && pwd)"
DST="$ROOT/model_weights/dedode"
mkdir -p "$DST"
uvx --from huggingface_hub hf download kornia/dedode dedode_detector_L_v2.pth --local-dir "$DST"
if [[ "${1:-}" == "--all" ]]; then
  uvx --from huggingface_hub hf download kornia/dedode dedode_detector_L.pth dedode_descriptor_B.pth --local-dir "$DST"
fi
ls -lh "$DST"
