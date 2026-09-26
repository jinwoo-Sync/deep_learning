#!/usr/bin/env bash
# Official LINEA release; --all also gets N and M.
set -euo pipefail
ROOT="$(cd "$(dirname "$0")/.." && pwd)"
DST="$ROOT/model_weights/linea"
mkdir -p "$DST"
BASE="https://github.com/SebastianJanampa/storage/releases/download/LINEA"
curl -fL --retry 3 --progress-bar -o "$DST/linea_hgnetv2_l.pth" "$BASE/linea_hgnetv2_l.pth"
if [[ "${1:-}" == "--all" ]]; then
  curl -fL --retry 3 --progress-bar -o "$DST/linea_hgnetv2_n.pth" "$BASE/linea_hgnetv2_n.pth"
  curl -fL --retry 3 --progress-bar -o "$DST/linea_hgnetv2_m.pth" "$BASE/linea_hgnetv2_m.pth"
fi
ls -lh "$DST"
