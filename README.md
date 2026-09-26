# deep_learning

TensorGraphX의 LiDAR–camera 보정에 사용할 모델 소스와 가중치 다운로드 안내다. 이 저장소는 TensorGraphX의 `3rd/deep_learning` submodule로 연결한다.

## 현재 선택한 모델

| 역할 | 모델 | 소스 | 가중치 |
|---|---|---|---|
| 점 검출 | DaD, DeDoDe v2 | `dad/`, `dedode/` | `model_weights/dad/dad.pth`, `model_weights/dedode/dedode_detector_L_v2.pth` |
| 기술자 | DINOv3 ViT-B/16, DINOv2 ViT-S/14 | `dinov3/`, `dinov2/` | `model_weights/dinov3/vitb16-hf/`, `model_weights/dinov2_vits14_pretrain.pth` |
| 교차 모달 매칭 | MINIMA LoFTR/XoFTR, XoFTR | `minima/`, `xoftr/` | `model_weights/minima/`, `model_weights/xoftr/` |
| 선 검출 | LINEA | `linea/` | `model_weights/linea/linea_hgnetv2_l.pth` |
| 깊이·3D | Depth Anything V2 Small, MapAnything Apache | `depth_anything_v2/`, `map_anything/` | `model_weights/depth_anything_v2/`, `model_weights/map_anything/` |
| 분할 | SAM 2.1 Hiera Small | `sam2/` | `model_weights/sam2/sam2.1_hiera_small.pt` |

ELSED는 **TensorGraphX의 `3rd/ELSED`** 에 있다. CPU C++ 소스이며 학습 가중치가 없다. DeepLSD와 DiffusionEdge는 Mac 실행 보류로 이 선택 목록에서 제외했다. LightGlue와 OmniGlue도 사용하지 않는다. 현재 TensorGraphX의 점 매처는 상호 최근접 매칭이며, DaD+DINOv3 집중 실행은 별도 파이프라인에서 확인했다.

## 다른 Mac·Ubuntu에서 시작

```bash
# TensorGraphX를 받은 뒤:
git submodule update --init --recursive
cd 3rd/deep_learning

# uv가 설치돼 있고, DINOv3 Hugging Face 접근 승인이 있는 경우:
uvx --from huggingface_hub hf auth login
bash scripts/fetch_all.sh
bash scripts/check_weights.sh
```

`fetch_all.sh`은 **가중치 파일만** 받는다. Python 프로젝트의 `uv sync`, C++ 빌드, 시스템 패키지 설치를 하지 않는다. 각 모델의 원본 링크, 개별 명령, 실행 파일 경로는 [model_weights/README.md](model_weights/README.md)에 있다. DINOv3는 Meta/Hugging Face 접근 조건에 동의해야 다운로드된다. MapAnything Apache 스냅샷은 약 4.9GB이다.

소스 checkout, 가중치 존재, Python 환경 설치, 실제 추론 성공은 서로 다른 상태다. 각 모델은 독립 `envs/<model>/` 프로젝트를 사용한다. 기존 Python 환경과 충돌 가능성이 있는 새 환경 설치는 여기서 자동 실행하지 않는다. Mac에서는 네이티브 MPS, Ubuntu NVIDIA에서는 별도 CUDA 환경을 검증한다. 이 worktree에서 모든 모델의 Mac 추론 성공을 주장하지 않는다.

## 원본과 라이선스

고정 소스 커밋과 출처는 [UPSTREAM.md](UPSTREAM.md)에 기록한다. Depth Anything V2는 Small 가중치만 Apache-2.0 대상으로 사용한다. MapAnything은 `facebook/map-anything-apache`를 사용한다. DINOv3의 모델 사용 조건은 Hugging Face 모델 페이지를 확인한다. 다운로드한 가중치는 로컬 파일로 보관하며 이 Git 브랜치에 올리지 않는다.
