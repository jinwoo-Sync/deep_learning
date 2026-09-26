# SAM3 on Apple Silicon

**반드시 이 모델 전용 `uv` 프로젝트의 `.venv`에서 설치·변환·실행한다.** 전역 Python이나 다른 모델 환경을 쓰지 않는다.

```bash
# deep_learning 루트에서
uv sync --project envs/sam3_macos --python 3.13
# 본인 Hugging Face 계정에서 facebook/sam3 접근 승인 후:
uv run --project envs/sam3_macos hf auth login
HF_HUB_DISABLE_XET=1 bash scripts/fetch_sam3.sh
uv run --project envs/sam3_macos python scripts/convert_sam3_mlx.py
uv run --project envs/sam3_macos python scripts/smoke_sam3_macos.py
```

2026-09-26 Mac에서 Python 3.13.15, `sam3-mlx==0.1.1`, MLX 0.32.2, PyTorch 2.14.0 설치와 `Device(gpu, 0)` 접근을 확인했다. 공식 `facebook/sam3`의 `sam3.pt`와 `config.json`을 받았고, 로컬 공식 가중치를 MLX로 변환했다. `truck.jpg` + `truck` 텍스트 프롬프트에서 score 0.864565와 `(1, 1, 1200, 1800)` 마스크를 얻었다. 원본은 `model_weights/sam3/official/`, 변환본은 `model_weights/sam3/mlx/`에 보관하며 둘 다 Git에서 제외한다. 변환본은 공식 가중치를 사용했고 커뮤니티 체크포인트를 자동 다운로드하지 않는다.

실패 이력: HF 승인 전에는 `Access denied. This repository requires approval.` 때문에 공식 파일을 받을 수 없었다. 첫 대용량 다운로드의 Xet 경로가 2.8GB 부근에서 멈춰 `HF_HUB_DISABLE_XET=1`로 재시도해 완료했다. sandbox의 Metal 접근은 `No Metal device available`로 실패했으나 호스트 GPU에서는 추론에 성공했다. 이 확인은 Mac **이미지** 분할이며 SAM3.1 멀티플렉스 추적이나 Ubuntu CUDA 추론 검증이 아니다.
