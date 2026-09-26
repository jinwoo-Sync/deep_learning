# deep_learning

TensorGraphX의 targetless LiDAR–camera 보정에 필요한 추론 소스를 모으는 저장소다.
TensorGraphX는 이 저장소를 `3rd/deep_learning` submodule로 고정한다.

| 경로 | 내용 | 가져오는 방식 |
|---|---|---|
| `dinov3/` | Meta 공식 DINOv3 소스와 `LICENSE.md` | 공식 커밋을 기록한 복사본. DINOv3 재배포 조건을 함께 유지한다. |
| `superpoint/` | Magic Leap SuperGluePretrainedNetwork의 SuperPoint 소스·가중치 | **원본 Git submodule**. Magic Leap 라이선스는 제3자 재배포를 허용하지 않으므로 이 저장소에 파일을 다시 커밋하지 않는다. |
| `model_weights/` | DINOv3 ViT-S/16 체크포인트 위치 안내 | Meta 승인 링크가 준비되면 내려받는다. 현재 가중치는 포함하지 않는다. |

처음 받은 뒤 `git submodule update --init --recursive`를 실행한다. Magic Leap
SuperPoint의 이용은 원본 `LICENSE`에 따르며, DINOv3는 `dinov3/LICENSE.md`에
따른다. 현재 연결하는 SuperPoint는 **검출기만** 사용하고 SuperGlue matcher는
실행하지 않는다. TensorGraphX가 그 단계를 DINOv3 특징량의 상호 매칭으로 바꾼다.

DINOv3 ViT-S/16 가중치는 [Meta 공식 모델 페이지](https://github.com/facebookresearch/dinov3#pretrained-models)의 접근 신청 후 받은 URL 또는 로컬 파일이 필요하다. 승인 전에
임의의 가중치 파일을 넣거나 공개 저장소에 게시하지 않는다.
