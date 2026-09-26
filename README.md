# deep_learning

TensorGraphX의 LiDAR–camera 보정에 사용할 모델 소스와 가중치 다운로드 안내다. 이 저장소는 TensorGraphX의 `3rd/deep_learning` submodule로 연결한다.

## 현재 선택한 모델

| 역할 | 모델 | 소스 | 가중치 |
|---|---|---|---|
| 점 검출 | DaD, DeDoDe v2 | `dad/`, `dedode/` | `model_weights/dad/dad.pth`, `model_weights/dedode/dedode_detector_L_v2.pth` |
| 기술자 | DINOv3 ViT-B/16 (기본); DINOv2 ViT-S/14 (비교 보관) | `dinov3/`, `dinov2/` | `model_weights/dinov3/vitb16-hf/`, `model_weights/dinov2_vits14_pretrain.pth` |
| 교차 모달 매칭 | MINIMA LoFTR/XoFTR, XoFTR | `minima/`, `xoftr/` | `model_weights/minima/`, `model_weights/xoftr/` |
| 선 검출 | LINEA | `linea/` | `model_weights/linea/linea_hgnetv2_l.pth` |
| 깊이·3D | Depth Anything V2 Small, MapAnything Apache | `depth_anything_v2/`, `map_anything/` | `model_weights/depth_anything_v2/`, `model_weights/map_anything/` |
| 분할 | SAM3 (기본); SAM 2.1 Hiera Small (소스·가중치 보관) | `sam3/`, `sam2/` | `model_weights/sam3/official/` 및 Mac 변환본 `model_weights/sam3/mlx/`; `model_weights/sam2/sam2.1_hiera_small.pt` |

ELSED는 **TensorGraphX의 `3rd/ELSED`** 에 있다. CPU C++ 소스이며 학습 가중치가 없다. DeepLSD와 DiffusionEdge는 Mac 실행 보류로 이 선택 목록에서 제외했다. LightGlue와 OmniGlue도 사용하지 않는다. 현재 TensorGraphX의 기본 점 매처는 DaD+DINOv3 상호 최근접이며, 기본 분할기는 SAM3다. SAM3는 정적 표면 마스크로 점 대응을 필터한다. DaD/DeDoDe+DINOv3 작은 CPU 추론과 SAM3 Mac GPU 이미지 추론을 각각 확인했다. SAM2는 실행 경로에 연결하지 않는다.

## 다른 Mac·Ubuntu에서 시작

```bash
# 새 머신: TensorGraphX 기본 브랜치를 받는다.
git clone https://github.com/jinwoo-Sync/TensorGraphX.git
cd TensorGraphX
git submodule update --init --recursive 3rd/deep_learning 3rd/ELSED
git -C 3rd/deep_learning submodule update --init --recursive
cd 3rd/deep_learning

# uv가 설치돼 있고, DINOv3 Hugging Face 접근 승인이 있는 경우:
uvx --from huggingface_hub hf auth login
bash scripts/fetch_all.sh
bash scripts/check_weights.sh
```

`fetch_all.sh`은 **가중치 파일만** 받는다. Python 프로젝트의 `uv sync`, C++ 빌드, 시스템 패키지 설치를 하지 않는다. 각 모델의 원본 링크, 개별 명령, 실행 파일 경로는 [model_weights/README.md](model_weights/README.md)에 있다. DINOv3는 Meta/Hugging Face 접근 조건에 동의해야 다운로드된다. MapAnything Apache 스냅샷은 약 4.9GB이다.

소스 checkout, 가중치 존재, Python 환경 설치, 실제 추론 성공은 서로 다른 상태다. 각 모델은 독립 `envs/<model>/` 프로젝트를 사용한다. 기존 Python 환경과 충돌 가능성이 있는 새 환경 설치는 여기서 자동 실행하지 않는다. Mac에서는 네이티브 MPS, Ubuntu NVIDIA에서는 별도 CUDA 환경을 검증한다. 모든 모델의 Mac 추론 성공을 주장하지 않는다.

## 원본과 라이선스

고정 소스 커밋과 출처는 [UPSTREAM.md](UPSTREAM.md)에 기록한다. Depth Anything V2는 Small 가중치만 Apache-2.0 대상으로 사용한다. MapAnything은 `facebook/map-anything-apache`를 사용한다. DINOv3의 모델 사용 조건은 Hugging Face 모델 페이지를 확인한다. 새로 다운로드한 가중치는 로컬 파일로 보관하며 Git에 올리지 않는다. 기존 DINOv3 ViT-B/16 Git LFS 사본은 별도로 유지한다.

## SAM3 설치 결과와 필수 환경 격리 (2026-09-26)

**모든 모델 submodule은 소스 저장용이다. 모델 추론은 반드시 모델별 독립 `uv` 프로젝트의 `.venv`에서 실행한다.** 전역 Python, 전역 `pip`, 다른 모델의 `.venv`를 사용하지 않는다. `uv sync --project envs/<모델>`로 설치하고 `uv run --project envs/<모델> ...`로 실행한다. SAM3는 Mac MLX용 `envs/sam3_macos/.venv`와 Ubuntu CUDA용 `envs/sam3_ubuntu/.venv`를 분리한다. Ubuntu 컨테이너 안에서도 `uv`를 사용한다.

| 단계 | 실제 확인 결과 |
|---|---|
| 공식 소스 | Meta `facebookresearch/sam3`를 별도 `sam3/` Git submodule로 checkout했다. |
| 공식 가중치 | 처음에는 `jinwoo31` 계정의 HF 승인이 없어 `config.json` 요청이 `Access denied. This repository requires approval.`로 실패했다. 승인 후 2026-09-26 `facebook/sam3`의 `sam3.pt`(3.2 GiB)와 `config.json`을 `model_weights/sam3/official/`에 다운로드했다. `sam3.pt` SHA-256: `9999e2341ceef5e136daa386eecb55cb414446a00ac2b55eb2dfd2f7c3cf8c9e`. SAM3.1은 다운로드하지 않았다. |
| Mac 환경 | 독립 `envs/sam3_macos/.venv`에 Python 3.13.15, `sam3-mlx==0.1.1`, MLX 0.32.2, PyTorch 2.14.0을 설치했다. sandbox의 Metal 장치 접근은 `No Metal device available`로 실패했지만 정상 호스트에서는 MLX `Device(gpu, 0)`를 확인했다. 공식 `.pt`를 1400개 텐서의 `model.safetensors`로 변환하고 `sam3/assets/images/truck.jpg`에 `truck` 프롬프트를 적용해 점수 0.864565, 마스크 shape `(1, 1, 1200, 1800)`을 확인했다. |
| Ubuntu 환경 | 호스트 주소가 없어 Ubuntu 설치, Docker 빌드, CUDA 장치 확인, 공식 SAM3 추론은 하지 않았다. `envs/sam3_ubuntu`에는 독립 `uv` 환경 정의만 준비했다. |

Mac 이미지 추론까지 검증했다. Ubuntu CUDA와 SAM3.1 영상 추론은 미검증이다. 승인 토큰과 가중치는 Git에 올리지 않는다. 공식 SAM3는 CUDA 실행 경로이며 Mac은 별도 MLX 포트를 사용한다. [공식 설치](https://github.com/facebookresearch/sam3#installation), [공식 가중치](https://huggingface.co/facebook/sam3), [Mac 포트](https://pypi.org/project/sam3-mlx/).

DINOv3 ViT-B/16의 승인된 별도 Git LFS 사본도 `model_weights/dinov3-vitb16-pretrain-lvd1689m/`에 유지한다. `fetch_all.sh`은 독립 다운로드 경로 `model_weights/dinov3/vitb16-hf/`를 검사한다.
