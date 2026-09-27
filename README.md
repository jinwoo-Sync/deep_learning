# deep_learning

TensorGraphX의 targetless LiDAR–camera 보정에 필요한 추론 소스를 모으는 저장소다.
TensorGraphX는 이 저장소를 `3rd/deep_learning` submodule로 고정한다.

| 경로 | 내용 | 가져오는 방식 |
|---|---|---|
| `dinov2/` | Meta 공식 DINOv2 소스와 Apache-2.0 `LICENSE` | 공식 커밋을 기록한 복사본. ViT-S/14를 현재 matcher에 사용한다. |
| `dinov3/` | Meta 공식 DINOv3 소스와 `LICENSE.md` | ViT-B/16 승인 가중치를 로컬 HF 형식으로 사용한다. |
| `DaD/`, `DeDoDe/` | 점 검출기 원본 | 각각 Git submodule; DeDoDe v2 detector만 기본 후보 |
| `MINIMA/`, `XoFTR/` | detector-free cross-modal 매처 원본 | Git submodule; MINIMA의 SuperPoint 기반 `minima_lightglue`는 사용 금지 |
| `DiffusionEdge/` | 엣지맵 원본 | Git submodule; 선분 추출은 TensorGraphX 별도 구현 |
| `SAM2/`, `MapAnything/`, `Depth-Anything-V2/` | 후속 mask·깊이·3D 평면 후보 소스 | Git submodule; 가중치별 사용 조건 분리 |
| `OmniGlue/` | DINOv2-guided 매칭 구조 참고 | Git submodule; 공식 추론은 SuperPoint를 요구하므로 상업 실행에서 제외 |
| `model_weights/` | DINOv2 ViT-S/14 및 DINOv3 체크포인트 | DINOv2 공식 공개 가중치는 Git LFS로 보관한다. 승인된 DINOv3 ViT-B/16 HF `safetensors` 파일은 Git LFS로 관리한다. |

처음 받은 뒤 `git submodule update --init --recursive`를 실행한다. 모델 원본의 존재는 가중치 확보나 Mac/RTX 추론 성공을 뜻하지 않는다. SuperPoint/SuperGlue는 상업 실행 경로에서 제거한다. DaD/DeDoDe 점 + DINOv3 descriptor와 MINIMA/XoFTR detector-free를 동일 입력으로 비교한다. OmniGlue 공식 경로는 SuperPoint 의존성이 있어 참조용으로만 둔다. MapAnything은 `facebook/map-anything-apache`, Depth Anything V2는 Small 가중치만 상업 경로로 사용한다. 상세 설계는 TensorGraphX의 `docs/TARGETLESS_COMMERCIAL_MATCHER_COMPARISON.md`에 기록한다.

**Built with DINOv3.** 승인된 [Meta 공식 ViT-B/16 모델](https://huggingface.co/facebook/dinov3-vitb16-pretrain-lvd1689m)을 `model_weights/dinov3-vitb16-pretrain-lvd1689m/`에 보관한다. `config.json`과 `model.safetensors`는 한 폴더에 있어야 하며 원본 `dinov3/LICENSE.md` 및 [Meta 라이선스](https://ai.meta.com/resources/models-and-libraries/dinov3-license/)를 따른다. HF safetensors는 Meta 원본 PyTorch hub 체크포인트와 키가 달라 `AutoModel.from_pretrained(..., local_files_only=True)`로 로딩한다. 인증 토큰은 보관하지 않는다.

DINOv2 기본 가중치는 [Meta 공개 ViT-S/14](https://dl.fbaipublicfiles.com/dinov2/dinov2_vits14/dinov2_vits14_pretrain.pth)이다. 모델 소스와 가중치의 Apache-2.0 조건은 [공식 저장소](https://github.com/facebookresearch/dinov2#license)를 따른다.

## SAM3 설치 시도와 실행 환경 규칙 (2026-09-26)

**모든 모델 submodule은 소스일 뿐이며, 추론은 반드시 모델별로 분리한 `uv` 프로젝트의 `.venv`에서 실행한다.** 전역 Python 또는 다른 모델의 `.venv`에 `pip install`하거나 그 인터프리터로 직접 실행하지 않는다. Mac과 Ubuntu용 SAM3 환경도 각각 `envs/sam3_macos/.venv`, `envs/sam3_ubuntu/.venv`로 분리한다. 실행 시 `uv run --project envs/<모델> ...` 또는 해당 프로젝트의 `.venv/bin/python`을 명시한다. Ubuntu 컨테이너도 동일하게 `uv sync`와 `uv run`을 사용해야 한다.

이 로컬 submodule 작업 트리의 HEAD는 `adce756`이며 이전 후보 모델 변경이 미커밋 상태로 남아 있다. TensorGraphX가 기록한 gitlink `4575015`와 작업 트리의 실제 checkout이 다르다. 별도 `이전자료/deep_learning` clone에서 Meta 공식 `sam3/` 소스를 받았고 Mac용 독립 `uv` 환경에 Python 3.13.15와 `sam3-mlx==0.1.1`을 설치했지만, 이 작업 트리에 SAM3 소스나 실행 성공이 반영된 것은 아니다.

| 단계 | 확인 결과 |
|---|---|
| 공식 가중치 | Hugging Face 로그인 계정 `jinwoo31`로 `facebook/sam3`와 `facebook/sam3.1`의 `config.json` 다운로드를 각각 시도했으나 모두 `Access denied. This repository requires approval.`로 거절됐다. `.pt` 가중치는 받지 못했다. |
| Mac MLX | `uv sync --project envs/sam3_macos --python 3.13`은 성공했다. sandbox 안에서 `import mlx.core`는 `No Metal device available`로 실패했다. sandbox 밖 재검증 요청은 중단됐으므로 실제 Mac Metal 추론 가능 여부는 미확인이다. |
| Ubuntu CUDA | Ubuntu 호스트가 지정되지 않아 Docker 이미지 빌드, CUDA 장치 확인, 공식 SAM3 추론을 실행하지 않았다. |

가중치 접근 승인, 환경 설치, 모델 import, 실제 mask 출력은 서로 다른 완료 조건이다. Meta 공식 SAM3는 CUDA를 전제로 하며 Mac용 MLX 포트는 별도 구현이다. 모델 가중치와 승인 토큰은 Git에 넣지 않는다. [SAM3 공식 설치 안내](https://github.com/facebookresearch/sam3#installation), [공식 가중치](https://huggingface.co/facebook/sam3), [Mac MLX 포트](https://pypi.org/project/sam3-mlx/).
