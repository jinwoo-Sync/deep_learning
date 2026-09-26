#!/usr/bin/env bash
# Official DaD release: default checkpoint; --all also gets light and dark.
set -euo pipefail
ROOT="$(cd "$(dirname "$0")/.." && pwd)"
DST="$ROOT/model_weights/dad"
mkdir -p "$DST"
BASE="https://github.com/Parskatt/DaD/releases/download/v0.1.0"
curl -fL --retry 3 --progress-bar -o "$DST/dad.pth" "$BASE/dad.pth"
if [[ "${1:-}" == "--all" ]]; then
  curl -fL --retry 3 --progress-bar -o "$DST/dad_light.pth" "$BASE/dad_light.pth"
  curl -fL --retry 3 --progress-bar -o "$DST/dad_dark.pth" "$BASE/dad_dark.pth"
fi
ls -lh "$DST"
