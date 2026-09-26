# Upstream provenance

소스는 각 submodule의 Git 커밋으로 고정한다. 가중치는 Git에 올리지 않고 [model_weights/README.md](model_weights/README.md)의 공식 출처에서 받는다.

| Component | Source | Pinned revision | Storage |
|---|---|---|---|
| DINOv3 | https://github.com/facebookresearch/dinov3 | `6876159a11b4df116f30f667f8c9888617df0751` | Source copy `dinov3/`; HF ViT-B/16 checkpoint |
| DINOv2 | https://github.com/facebookresearch/dinov2 | `dinov2/UPSTREAM_COMMIT.txt` 참조 | Source copy `dinov2/`; ViT-S/14 checkpoint |
| DeDoDe | https://github.com/Parskatt/DeDoDe | `6d156183f4dc84cd704ae779eebc8350995c5b06` | `dedode/` |
| DaD | https://github.com/Parskatt/DaD | `c2ee9e111191c84cc7f79f0e10d04978784af26f` | `dad/` |
| LINEA | https://github.com/SebastianJanampa/LINEA | `475c5ceea64114a48495c15888094e12f1a2d267` | `linea/` |
| MINIMA | https://github.com/LSXI7/MINIMA | `796e7721174f9f829b79b3702bf8c2ae9a3d447a` | `minima/`, nested LoFTR/XoFTR |
| XoFTR | https://github.com/OnderT/xoftr | `e0fbea431b30be9742effbf5577c90aa8eb938f9` | `xoftr/` |
| Depth Anything V2 Small | https://github.com/DepthAnything/Depth-Anything-V2 | `a561b849ebae10a6f5ef49e26c83cbbcd36c71bf` | `depth_anything_v2/` |
| MapAnything | https://github.com/facebookresearch/map-anything | `3d10cf7a3016fc0f9bb13a071ee66c47b10be0d9` | `map_anything/`; Apache checkpoint |
| SAM 2.1 | https://github.com/facebookresearch/sam2 | `2b90b9f5ceec907a1c18123530e92e794ad901a4` | `sam2/`; Hiera Small checkpoint |
| ELSED | https://github.com/iago-suarez/ELSED | `1878213b2f5f06a9261d8b1838f53d48e5fd128d` | TensorGraphX `3rd/ELSED/`; no weights |

DeepLSD와 DiffusionEdge는 Mac 실행 보류. LightGlue와 OmniGlue는 현재 사용하지 않는다. TensorGraphX의 현행 점 매칭은 상호 최근접 방식이다. Python 환경을 강제로 설치하지 않는다.
