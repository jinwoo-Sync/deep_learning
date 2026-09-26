# deep_learning

TensorGraphX의 LiDAR–camera 보정 후보 모델 소스와 독립 실행 환경이다. 이 저장소는 TensorGraphX에서 `3rd/deep_learning` submodule로 참조한다.

| 모델 | 소스 | 환경 | 역할 |
|---|---|---|---|
| DaD | `dad/` | `envs/dedode/` | 점 검출 후보 |
| DeDoDe v2 | `dedode/` | `envs/dedode/` | 점 검출 비교군 |
| DeepLSD | `deeplsd/` | `envs/deeplsd/` | 야외 선 검출 후보. 추론은 Ceres refinement 없이 가능 |
| LINEA | `linea/` | `envs/linea/` | 선 검출 비교군 |
| ELSED | `elsed/` | 미설치 | CPU 선 검출 기준선. 학습 가중치 없음 |
| MINIMA / XoFTR | `minima/`, `xoftr/` | `envs/minima/`, `envs/xoftr/` | cross-modal 비교군. 환경 설치는 별도 검증 필요 |
| Depth Anything V2 Small | `depth_anything_v2/` | `envs/depth_anything_v2/` | 가벼운 상대 깊이 후보. 공식 MPS 분기 있음 |
| MapAnything | `map_anything/` | `envs/map_anything/` | metric 3D/깊이 후보. 최신 코드에 MPS 지원 경로 있음 |
| DINOv2 / DINOv3 | `dinov2/`, `dinov3/` | 파이프라인 환경 | descriptor. DINOv3 ViT-B/16 HF 가중치는 Git LFS에 보관 |

`uv` 환경은 서로 격리된다. Mac 개발은 네이티브 환경을 사용한다. Ubuntu 차량에서는 NVIDIA Docker를 별도로 구성한다. 현재 매칭은 TensorGraphX의 상호 최근접 방식이며 LightGlue는 이 저장소에서 제거했다.

## 2026-09-26 실제 준비 상태

**Built with DINOv3.** 승인된 Meta ViT-B/16 HF 모델은 `model_weights/dinov3-vitb16-pretrain-lvd1689m/`에 Git LFS로 보관한다. `config.json`과 `model.safetensors`는 한 폴더에 있으며 `dinov3/LICENSE.md`와 Meta 라이선스를 따른다.

| 항목 | 소스 | 독립 uv 환경 | 가중치 | 실행 상태 |
|---|---|---|---|---|
| DaD / DeDoDe | 있음 | `envs/dedode` 설치 | 없음 | 이 저장소 가중치 추론 전. TensorGraphX의 DaD+DINOv3 CPU 집중 실행은 별도 작업에서 확인 |
| LINEA | 있음 | `envs/linea` 설치 | 없음 | 추론 전 |
| DeepLSD | 있음 | **설치 실패, 사용 보류** | 없음 | `pytlsd`에 고정된 pybind11 2.6.2가 Python 3.12에서 컴파일 실패. 기존 환경은 변경하지 않음 |
| ELSED | 있음 | 미설치 | 불필요 | C++/Python 바인딩 빌드 전. 기존 환경에 설치하지 않음 |
| MINIMA / XoFTR | 있음. MINIMA-LoFTR·MINIMA-XoFTR 하위 소스 초기화 완료 | 미설치 | 없음 | 추론 전 |
| Depth Anything V2 Small / MapAnything | 있음 | 미설치 | 없음 | 추론 전 |
| DINOv2 / DINOv3 | 있음 | 파이프라인 환경 | 기존 ViT-S/14 및 ViT-B/16 HF 있음 | 별도 파이프라인 상태 확인 필요 |
| OmniGlue / LightGlue | **submodule 없음** | 없음 | 없음 | 사용하지 않음. 문서의 이름은 연구 후보 또는 상류 코드 참고 |

추가 소스와 문서는 TensorGraphX의 `3rd/deep_learning` submodule 포인터로 고정한다.

사용자 요청에 따라 DeepLSD 빌드를 더 밀어붙이지 않는다. 깊이 모델의 환경도 자동 설치하지 않는다. 새 환경을 쓸 때는 해당 모델의 독립 `envs/<model>/` 프로젝트만 선택한다.


가중치는 사용자가 직접 받는다. 정확한 경로와 명령은 [`model_weights/README.md`](model_weights/README.md)에 있다. DeepLSD의 `deeplsd_md.tar`는 야외 영상용이고, `deeplsd_wireframe.tar`는 실내 비교용이다. 공식 [DeepLSD README](https://github.com/cvg/DeepLSD#quickstart-install-for-inference-only)는 추론 설치와 Ceres가 필요한 full/refinement 설치를 구분한다. DeepLSD 추론에도 `pytlsd` CMake 네이티브 확장은 필요하므로 순수 Python 설치는 아니다.

추가 후보 모델의 가중치가 준비되기 전에는 해당 모델의 정확도나 MPS 추론 성공을 검증할 수 없다. 이 실행 세션의 `torch.backends.mps.is_available()` 값은 `False`였다.

## 설치 상태의 뜻

`git submodule`은 **소스 확보**, `uv sync`는 **Python 의존성 설치**, `model_weights/`는 **가중치 준비**, 실제 이미지 추론은 **동작 검증**이다. 각 단계는 별개다. OmniGlue는 submodule로 설치한 적 없으며 설계 참고 문헌으로만 남긴다. MapAnything의 공식 README 예시는 CUDA/CPU를 고르지만 최신 소스의 `get_device()`에는 MPS 분기가 있다. 이 환경에서 가중치 기반 MPS 실측은 아직 하지 않았다.

## 선 검출 선택

ELSED는 [공식 저장소](https://github.com/iago-suarez/ELSED)의 Apache-2.0 CPU C++ 검출기이며 학습 가중치가 필요 없다. 빠른 온라인 기준선으로 유용하다. Python 바인딩은 CMake, OpenCV 개발 헤더, pybind11을 요구하므로 Mac에서의 빌드 성공은 아직 검증하지 않았다. DeepLSD는 야외용 학습 체크포인트가 있는 정확도 후보지만 현재 `pytlsd` Python 3.12 빌드 오류로 사용 보류다. LINEA는 환경만 설치됐고 가중치가 없다. 셋의 정확도 우열은 같은 실측 데이터로 확인해야 한다.

## 우선 다운로드 명령

Depth Anything V2 **Small**, MINIMA **LoFTR/XoFTR**의 사용자 실행 명령과 정확한 저장 경로는 [`model_weights/README.md`](model_weights/README.md#지금-먼저-받을-3개-모델)에 있다. 실행 경로에 필요한 MINIMA 하위 소스 두 개는 초기화했다. 가중치는 아직 받지 않았다.

## SAM3 설치 결과와 필수 환경 격리 (2026-09-26)

**모든 모델 submodule은 소스 저장용이다. 모델 추론은 반드시 모델별 독립 `uv` 프로젝트의 `.venv`에서 실행한다.** 전역 Python, 전역 `pip`, 다른 모델의 `.venv`를 사용하지 않는다. `uv sync --project envs/<모델>`로 설치하고 `uv run --project envs/<모델> ...`로 실행한다. SAM3는 Mac MLX용 `envs/sam3_macos/.venv`와 Ubuntu CUDA용 `envs/sam3_ubuntu/.venv`를 분리한다. Ubuntu 컨테이너 안에서도 `uv`를 사용한다.

| 단계 | 실제 확인 결과 |
|---|---|
| 공식 소스 | Meta `facebookresearch/sam3`를 별도 `sam3/` Git submodule로 checkout했다. 소스 확보만 확인했다. |
| 공식 가중치 | Hugging Face 계정 `jinwoo31`은 `facebook/sam3`와 `facebook/sam3.1` 접근 승인이 없다. 각각 `config.json` 다운로드가 `Access denied. This repository requires approval.`로 실패했다. `.pt` 체크포인트는 받지 못했다. |
| Mac 환경 | `uv sync --project envs/sam3_macos --python 3.13`이 성공해 Python 3.13.15, `sam3-mlx==0.1.1`, MLX 0.32.2를 독립 `.venv`에 설치했다. sandbox 안에서 `import mlx.core`는 `No Metal device available`로 실패했다. sandbox 밖 검증 요청은 중단돼 실제 Mac GPU 추론은 미확인이다. |
| Ubuntu 환경 | 호스트 주소가 없어 Ubuntu 설치, Docker 빌드, CUDA 장치 확인, 공식 SAM3 추론은 하지 않았다. `envs/sam3_ubuntu`에는 독립 `uv` 환경 정의만 준비했다. |

가중치 접근 승인, 소스 checkout, 패키지 설치, 실제 mask 출력은 별도 상태다. 승인 토큰과 가중치는 Git에 올리지 않는다. 공식 SAM3는 CUDA 실행 경로이며 Mac은 별도 MLX 포트를 사용한다. [공식 설치](https://github.com/facebookresearch/sam3#installation), [공식 가중치](https://huggingface.co/facebook/sam3), [Mac 포트](https://pypi.org/project/sam3-mlx/).
