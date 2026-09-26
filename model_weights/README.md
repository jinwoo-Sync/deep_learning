# 모델 가중치 다운로드와 경로

이 문서는 **다른 Mac 또는 Ubuntu에서 같은 체크포인트를 다시 받기 위한 실행 계약**이다. 아래의 설치 절차는 TensorGraphX 저장소 루트에서 시작하며, 가중치 명령은 `3rd/deep_learning` 루트에서 실행한다. TensorGraphX 기본 브랜치의 `3rd/deep_learning` gitlink가 고정한 커밋을 사용한다. 소스는 `git submodule update --init --recursive`로 받는다. 가중치 다운로드는 기존 venv를 변경하지 않는다.

## 한 번에 받기

```bash
# TensorGraphX 저장소 루트에서 실행:
git submodule update --init --recursive 3rd/deep_learning 3rd/ELSED
cd 3rd/deep_learning
# deep_learning 저장소만 별도 clone했다면 clone한 저장소 루트로 cd한다.
# uv가 없다면 먼저 https://docs.astral.sh/uv/getting-started/installation/ 에서 설치
# DINOv3 접근 조건에 동의한 HF 계정만 로그인 필요:
uvx --from huggingface_hub hf auth login
bash scripts/fetch_all.sh
bash scripts/check_weights.sh
```

`fetch_all.sh`은 이미 있는 선택 체크포인트를 건너뛴다. 별도 실행은 아래와 같다. `uvx`는 CLI를 격리해 실행하며 모델별 `.venv`를 설치하지 않는다.

| 모델 | 공식 출처 | 저장 위치 | 개별 명령 |
|---|---|---|---|
| DINOv3 ViT-B/16 | [Meta HF](https://huggingface.co/facebook/dinov3-vitb16-pretrain-lvd1689m) | `model_weights/dinov3/vitb16-hf/{config.json,model.safetensors}` | `bash scripts/fetch_dinov3.sh` |
| DINOv2 ViT-S/14 | [Meta 공개 체크포인트](https://dl.fbaipublicfiles.com/dinov2/dinov2_vits14/dinov2_vits14_pretrain.pth) | `model_weights/dinov2_vits14_pretrain.pth` | `bash scripts/fetch_dinov2.sh` |
| DaD | [공식 release](https://github.com/Parskatt/DaD/releases/tag/v0.1.0) | `model_weights/dad/dad.pth` | `bash scripts/fetch_dad.sh` |
| DeDoDe v2 검출기 | [Kornia HF mirror](https://huggingface.co/kornia/dedode/tree/main) | `model_weights/dedode/dedode_detector_L_v2.pth` | `bash scripts/fetch_dedode.sh` |
| MINIMA LoFTR·XoFTR | [공식 MINIMA release](https://github.com/LSXI7/storage/releases/tag/MINIMA) | `model_weights/minima/minima_loftr.ckpt`, `minima_xoftr.ckpt` | `bash scripts/fetch_minima.sh` |
| XoFTR 640·840 | [저자 Drive 폴더](https://drive.google.com/drive/folders/1RAI243OHuyZ4Weo1NiTy280bCE_82s4q) | `model_weights/xoftr/weights_xoftr_{640,840}.ckpt` | `bash scripts/fetch_xoftr.sh` |
| LINEA L | [공식 모델 배포](https://github.com/SebastianJanampa/LINEA#model-zoo) | `model_weights/linea/linea_hgnetv2_l.pth` | `bash scripts/fetch_linea.sh` |
| Depth Anything V2 Small | [공식 HF](https://huggingface.co/depth-anything/Depth-Anything-V2-Small) | `model_weights/depth_anything_v2/depth_anything_v2_vits.pth` | `bash scripts/fetch_depth_anything_v2.sh` |
| MapAnything Apache | [Meta HF](https://huggingface.co/facebook/map-anything-apache) | `model_weights/map_anything/{config.json,model.safetensors}` | `bash scripts/fetch_map_anything.sh` |
| SAM 2.1 Hiera Small | [Meta 공식 checkpoints](https://github.com/facebookresearch/sam2#download-checkpoints) | `model_weights/sam2/sam2.1_hiera_small.pt` | `bash scripts/fetch_sam2.sh` |
| SAM3 공식 이미지 | [Meta HF, 승인 필요](https://huggingface.co/facebook/sam3) | `model_weights/sam3/official/{sam3.pt,config.json}` | `HF_HUB_DISABLE_XET=1 bash scripts/fetch_sam3.sh` |

기존 DINOv2 파일이 없다면:

```bash
curl -fL --retry 3 -o model_weights/dinov2_vits14_pretrain.pth \
  https://dl.fbaipublicfiles.com/dinov2/dinov2_vits14/dinov2_vits14_pretrain.pth
```

DINOv3는 ViT-B/16 **Hugging Face 모델 폴더 전체**가 필요하다. TensorGraphX 매처는 `hidden_size=768`과 register tokens 4개를 확인한다. 단독 `.pth`나 ViT-S/16 경로는 현재 옵션과 맞지 않는다. 예: `--dino-weights "$PWD/model_weights/dinov3/vitb16-hf"`. MINIMA-XoFTR 매처 예: `--matcher-weights "$PWD/model_weights/minima/minima_xoftr.ckpt"`. 실제 실행 옵션은 TensorGraphX README를 확인한다.

MapAnything은 Apache-2.0 체크포인트 **`facebook/map-anything-apache`** 를 받는다. 기본 `facebook/map-anything`은 다른 라이선스다. Depth Anything V2 Small만 현재 Apache-2.0 대상으로 선택했다. DeepLSD·DiffusionEdge는 실행 보류로 다운로드 대상에서 제외했다. ELSED는 TensorGraphX `3rd/ELSED`의 CPU C++ 코드만 필요하며 가중치가 없다. LightGlue·OmniGlue도 설치 대상이 아니다.

`check_weights.sh`는 파일 존재와 크기만 확인한다. 추론 성공이나 Mac MPS 호환성 검증은 모델별 환경에서 별도로 진행한다. 새로 받은 가중치는 Git에 커밋하지 않는다. 기존 DINOv3 LFS 사본은 유지한다.

## 전송 무결성 확인

2026-09-26에 공식 출처에서 받은 선택 체크포인트 12개의 SHA-256을 [CHECKPOINT_SHA256SUMS](CHECKPOINT_SHA256SUMS)에 기록했다. 다른 머신에서 다시 받은 뒤 다음을 실행한다.

```bash
cd model_weights
shasum -a 256 -c CHECKPOINT_SHA256SUMS
```

이 검사는 **바이트가 같은지** 확인한다. `config.json` 등 작은 메타데이터 파일의 존재는 `scripts/check_weights.sh`가 확인한다.

## 기존 DINOv3 Git LFS 사본과 SAM3

기본 브랜치에서 관리하던 승인된 DINOv3 ViT-B/16 Git LFS 사본은 `model_weights/dinov3-vitb16-pretrain-lvd1689m/`에 그대로 유지한다. 현재 다운로드·검사 스크립트는 별도 경로 `model_weights/dinov3/vitb16-hf/`를 사용한다. 두 경로 모두 모델 폴더를 `--dino-weights`에 전달할 수 있다. LFS 사본이 포인터만 남았다면 `bash scripts/fetch_all.sh`을 실행한다.

SAM3는 사용자 계정 접근 승인 후 공식 `facebook/sam3` 체크포인트를 별도로 받았다. 다른 계정도 모델 접근 승인이 필요하다. `fetch_all.sh`에는 넣지 않았다. `sam3.pt` SHA-256은 `9999e2341ceef5e136daa386eecb55cb414446a00ac2b55eb2dfd2f7c3cf8c9e`이다. Mac에서는 반드시 `envs/sam3_macos/.venv`, Ubuntu에서는 `envs/sam3_ubuntu/.venv`를 사용한다. Mac 공식 체크포인트 변환과 이미지 추론은 [Mac 실행 안내](../envs/sam3_macos/README.md)를 따른다. 가중치와 HF 토큰은 Git에 올리지 않는다.
