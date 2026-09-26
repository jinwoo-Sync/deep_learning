#!/usr/bin/env bash
# Run only when the user wants to download all primary model weights.
set -euo pipefail
cd "$(dirname "$0")"
./fetch_dad.sh
./fetch_dedode.sh
./fetch_linea.sh
echo "Optional weights: ./fetch_deeplsd.sh, ./fetch_depth_anything_v2.sh, ./fetch_map_anything.sh, ./fetch_minima.sh, ./fetch_xoftr.sh"
