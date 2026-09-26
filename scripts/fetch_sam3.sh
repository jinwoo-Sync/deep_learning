#!/usr/bin/env bash
set -euo pipefail
ROOT="$(cd "$(dirname "$0")/.." && pwd)"
DST="$ROOT/model_weights/sam3/official"
mkdir -p "$DST"
hf download facebook/sam3 sam3.pt config.json --local-dir "$DST"
test -s "$DST/sam3.pt"
ls -lh "$DST/sam3.pt" "$DST/config.json"
