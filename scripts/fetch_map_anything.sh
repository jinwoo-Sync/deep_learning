#!/usr/bin/env bash
# Explicit Apache checkpoint. Do not substitute facebook/map-anything (CC-BY-NC).
set -euo pipefail
ROOT="$(cd "$(dirname "$0")/.." && pwd)"
DST="$ROOT/model_weights/map_anything"
mkdir -p "$DST"
uvx --from huggingface_hub hf download facebook/map-anything-apache --revision 00f9c245bbcb60522d1ed7f9e9d88462c6e3f38a --local-dir "$DST"
echo "Use MapAnything.from_pretrained('$DST')"
