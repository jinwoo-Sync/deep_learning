# deep_learning

TensorGraphX의 targetless LiDAR–camera 보정에 필요한 추론 소스를 모으는 저장소다.
TensorGraphX는 이 저장소를 `3rd/deep_learning` submodule로 고정한다.

| 경로 | 내용 | 가져오는 방식 |
|---|---|---|
| `dinov2/` | Meta 공식 DINOv2 소스와 Apache-2.0 `LICENSE` | 공식 커밋을 기록한 복사본. ViT-S/14를 현재 matcher에 사용한다. |
| `dinov3/` | Meta 공식 DINOv3 소스와 `LICENSE.md` | ViT-B/16 승인 가중치를 로컬 HF 형식으로 사용한다. |
| `superpoint/` | `rpautrat/SuperPoint`의 PyTorch 검출기·`weights/superpoint_v6_from_tf.pth` | MIT 원본 Git submodule. |
| `model_weights/` | DINOv2 ViT-S/14 및 DINOv3 체크포인트 | DINOv2 공식 공개 가중치는 Git LFS로 보관한다. 승인된 DINOv3 ViT-B/16 HF `safetensors` 파일은 Git LFS로 관리한다. |

처음 받은 뒤 `git submodule update --init --recursive`를 실행한다. `rpautrat/SuperPoint`는 MIT `LICENSE.txt`와 함께 받는다. SuperPoint는 **검출기만** 사용하고 SuperGlue matcher는 실행하지 않는다. TensorGraphX는 현재 DINOv2 ViT-S/14의 patch feature를 SuperPoint 위치에서 표본해 상호 최근접 매칭한다. 기본 matcher는 DINOv3 ViT-B/16이며, DINOv2는 비교용으로 남긴다. 두 방식의 정확도를 SuperGlue와 동일하다고 가정하지 않는다.

**Built with DINOv3.** 승인된 [Meta 공식 ViT-B/16 모델](https://huggingface.co/facebook/dinov3-vitb16-pretrain-lvd1689m)을 `model_weights/dinov3-vitb16-pretrain-lvd1689m/`에 보관한다. `config.json`과 `model.safetensors`는 한 폴더에 있어야 하며 원본 `dinov3/LICENSE.md` 및 [Meta 라이선스](https://ai.meta.com/resources/models-and-libraries/dinov3-license/)를 따른다. HF safetensors는 Meta 원본 PyTorch hub 체크포인트와 키가 달라 `AutoModel.from_pretrained(..., local_files_only=True)`로 로딩한다. 인증 토큰은 보관하지 않는다.

DINOv2 기본 가중치는 [Meta 공개 ViT-S/14](https://dl.fbaipublicfiles.com/dinov2/dinov2_vits14/dinov2_vits14_pretrain.pth)이다. 모델 소스와 가중치의 Apache-2.0 조건은 [공식 저장소](https://github.com/facebookresearch/dinov2#license)를 따른다.
