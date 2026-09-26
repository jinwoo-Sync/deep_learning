# deep_learning

TensorGraphX의 targetless LiDAR–camera 보정에 필요한 추론 소스를 모으는 저장소다.
TensorGraphX는 이 저장소를 `3rd/deep_learning` submodule로 고정한다.

| 경로 | 내용 | 가져오는 방식 |
|---|---|---|
| `dinov2/` | Meta 공식 DINOv2 소스와 Apache-2.0 `LICENSE` | 공식 커밋을 기록한 복사본. ViT-S/14를 현재 matcher에 사용한다. |
| `dinov3/` | Meta 공식 DINOv3 소스와 `LICENSE.md` | 승인 가중치가 준비되면 선택 가능하다. |
| `superpoint/` | `rpautrat/SuperPoint`의 PyTorch 검출기·`weights/superpoint_v6_from_tf.pth` | MIT 원본 Git submodule. |
| `model_weights/` | DINOv2 ViT-S/14 및 DINOv3 체크포인트 | DINOv2 공식 공개 가중치는 Git LFS로 보관한다. DINOv3는 승인 후 별도 준비한다. |

처음 받은 뒤 `git submodule update --init --recursive`를 실행한다. `rpautrat/SuperPoint`는 MIT `LICENSE.txt`와 함께 받는다. SuperPoint는 **검출기만** 사용하고 SuperGlue matcher는 실행하지 않는다. TensorGraphX는 현재 DINOv2 ViT-S/14의 patch feature를 SuperPoint 위치에서 표본해 상호 최근접 매칭한다. DINOv3는 승인 가중치가 생긴 뒤 비교한다. 두 방식의 정확도를 SuperGlue와 동일하다고 가정하지 않는다.

DINOv3 ViT-S/16 가중치는 [Meta 공식 모델 페이지](https://github.com/facebookresearch/dinov3#pretrained-models)의 접근 신청 후 받은 URL 또는 로컬 파일이 필요하다. 승인 전에
임의의 가중치 파일을 넣거나 공개 저장소에 게시하지 않는다.

DINOv2 기본 가중치는 [Meta 공개 ViT-S/14](https://dl.fbaipublicfiles.com/dinov2/dinov2_vits14/dinov2_vits14_pretrain.pth)이다. 모델 소스와 가중치의 Apache-2.0 조건은 [공식 저장소](https://github.com/facebookresearch/dinov2#license)를 따른다.
