# Model weights

코드는 설치한다. **가중치 다운로드는 사용자가 직접 실행한다.** 현재 DINOv2 ViT-S/14와 승인된 DINOv3 ViT-B/16 HF 가중치가 준비돼 있다. `.pth`, `.ckpt`, `.tar`는 대용량이므로 다운로드 후 Git에 올리기 전에 배포 조건을 확인한다.

## 다음에 받을 후보 모델

소스는 `dinov3/`, `depth_anything_v2/`, `minima/`에 있다. MINIMA 실행에 필요한 `minima/third_party/LoFTR_minima`와 `minima/third_party/XoFTR`도 받아 두었다. 아래 명령은 **사용자가 직접** 실행한다. 기존 Python 환경은 변경하지 않는다.

```bash
cd /Users/jinwoo.seo/Documents/개인개발/정리/이전자료/deep_learning

# 선택: DINOv3를 별도 폴더에 다시 받을 때만 사용. 먼저 https://huggingface.co/facebook/dinov3-vitb16-pretrain-lvd1689m 에서 접근 조건 동의
uvx --from huggingface_hub hf auth login
./scripts/fetch_dinov3.sh
# 저장: model_weights/dinov3/vitb16-hf/{config.json,model.safetensors,...}
# TensorGraphX 실행 옵션: --dino-weights "$PWD/model_weights/dinov3-vitb16-pretrain-lvd1689m" (기존 LFS 파일)

# 2. Depth Anything V2 Small: 공개 체크포인트
./scripts/fetch_depth_anything_v2.sh
# 저장: model_weights/depth_anything_v2/depth_anything_v2_vits.pth

# 3. MINIMA-LoFTR + MINIMA-XoFTR: 공식 GitHub release
./scripts/fetch_minima.sh
# 저장: model_weights/minima/minima_loftr.ckpt, minima_xoftr.ckpt
# TensorGraphX 실행 옵션: --matcher-weights "$PWD/model_weights/minima/minima_xoftr.ckpt"
```

**DINOv3 모델 크기 주의:** 현재 TensorGraphX `targetless_feature_matches.py`는 `hidden_size=768`인 **ViT-B/16** 및 4 register tokens를 검사한다. ViT-S/16이나 Meta의 단독 `.pth` 대신 위 Hugging Face 모델 폴더를 전달한다. HF 모델은 접근 조건 동의와 로그인 없이는 받을 수 없다. MINIMA는 위 두 가중치 외 다른 백본이 필요할 때만 추가로 받는다.

```bash
cd /Users/jinwoo.seo/Documents/개인개발/정리/이전자료/deep_learning
./scripts/fetch_dad.sh       # model_weights/dad/dad.pth
./scripts/fetch_dedode.sh    # model_weights/dedode/dedode_detector_L_v2.pth
./scripts/fetch_deeplsd.sh   # model_weights/deeplsd/deeplsd_md.tar (야외 권장)
./scripts/fetch_linea.sh     # model_weights/linea/linea_hgnetv2_l.pth
./scripts/fetch_depth_anything_v2.sh  # model_weights/depth_anything_v2/depth_anything_v2_vits.pth
./scripts/fetch_map_anything.sh       # model_weights/map_anything/ (Apache snapshot)
```

DaD·DeDoDe·LINEA 스크립트의 `--all` 옵션은 선택 가중치를 추가한다. `./scripts/fetch_all.sh`은 이 세 모델의 기본 가중치만 받는다. DeepLSD는 설치 보류 상태이므로 개별 스크립트로만 받는다. MINIMA는 `./scripts/fetch_minima.sh`, XoFTR은 `./scripts/fetch_xoftr.sh`를 별도 실행한다. XoFTR은 공식 Google Drive에서 내려받아 `model_weights/xoftr/weights_xoftr_640.ckpt`에 둔다.

DINOv2 기존 파일: `model_weights/dinov2_vits14_pretrain.pth` (SHA-256 `b938bf1bc15cd2ec0feacfe3a1bb553fe8ea9ca46a7e1d8d00217f29aef60cd9`). DINOv3 승인 HF 스냅샷은 기존 `model_weights/dinov3-vitb16-pretrain-lvd1689m/`에 있다.

출처: [DaD](https://github.com/Parskatt/DaD), [DeDoDe HF](https://huggingface.co/kornia/dedode), [DeepLSD](https://github.com/cvg/DeepLSD#usage), [LINEA](https://github.com/SebastianJanampa/LINEA#model-zoo).

Depth Anything V2는 **Small**만 Apache-2.0이다. MapAnything은 `facebook/map-anything-apache`만 상업 후보로 기록한다. 기본 `facebook/map-anything` 체크포인트와 혼동하지 않는다. 두 모델 모두 현재 가중치는 비어 있다.

**Built with DINOv3.** 승인된 Meta ViT-B/16 HF 모델은 `dinov3-vitb16-pretrain-lvd1689m/`에 이미 보관돼 있다. `config.json`, `preprocessor_config.json`, `model.safetensors`가 포함되며 safetensors는 Git LFS로 추적한다. SHA-256: `9a21ac3df0c63839d62612dda6f454d816c25611cc7a52966ed5a5a94921dc8b`.
