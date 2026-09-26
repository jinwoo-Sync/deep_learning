#!/usr/bin/env bash
# Official Small model; weights released under Apache-2.0.
set -euo pipefail
ROOT="$(cd "$(dirname "$0")/.." && pwd)"
DST="$ROOT/model_weights/depth_anything_v2"
mkdir -p "$DST"
uvx --from huggingface_hub hf download depth-anything/Depth-Anything-V2-Small depth_anything_v2_vits.pth --revision 03876f8651c73a60fe4c2c48294e09fcb6838fcf --local-dir "$DST"
ls -lh "$DST"
