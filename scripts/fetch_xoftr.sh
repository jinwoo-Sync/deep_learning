#!/usr/bin/env bash
# XoFTR weights (Apache-2.0) — 우선순위 낮음(비교군)
# ⚠️ 저자 배포가 Google Drive라 CLI 자동화가 막힌다. 수동 다운로드 후 이 스크립트로 배치 확인만 한다.
#    https://drive.google.com/drive/folders/1RAI243OHuyZ4Weo1NiTy280bCE_82s4q
#    → weights_xoftr_640.ckpt (권장) / weights_xoftr_840.ckpt
# → model_weights/xoftr/
set -euo pipefail
ROOT="$(cd "$(dirname "$0")/.." && pwd)"
DST="$ROOT/model_weights/xoftr"
mkdir -p "$DST"
echo "[i] Google Drive에서 받은 .ckpt 를 다음 경로에 두세요:"
echo "    $DST/weights_xoftr_640.ckpt"
echo
echo "[i] gdown 으로 폴더 전체를 시도할 수도 있습니다(실패 시 브라우저 사용):"
echo "    uvx gdown --folder https://drive.google.com/drive/folders/1RAI243OHuyZ4Weo1NiTy280bCE_82s4q -O $DST"
echo
if ls "$DST"/*.ckpt >/dev/null 2>&1; then echo "[✓] 배치됨:"; ls -lh "$DST"/*.ckpt; else echo "[ ] 아직 없음"; fi
echo
echo "[대안] MINIMA-XoFTR 가중치를 쓰면 Google Drive 없이 진행 가능: scripts/fetch_minima.sh"
