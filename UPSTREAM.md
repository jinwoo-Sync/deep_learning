# Upstream provenance

| Component | Source | Pinned revision | Storage |
|---|---|---|---|
| DINOv3 | https://github.com/facebookresearch/dinov3 | `6876159a11b4df116f30f667f8c9888617df0751` | Source copy in `dinov3/`, including upstream `LICENSE.md` |
| DeDoDe detector | https://github.com/Parskatt/DeDoDe | `6d156183f4dc84cd704ae779eebc8350995c5b06` | MIT Git submodule `dedode/`; weights from HF `kornia/dedode` |
| DaD detector | https://github.com/Parskatt/DaD | `c2ee9e111191c84cc7f79f0e10d04978784af26f` | MIT Git submodule `dad/`; PyPI `dad-detector==0.2.2`; weights from GitHub release v0.1.0 |
| DeepLSD line detector | https://github.com/cvg/DeepLSD | `f7d9d6258c0cd25d4f6eea882853565403d289be` | MIT Git submodule `deeplsd/`; official md/wireframe weights in `model_weights/deeplsd/` |
| ELSED CPU line detector | https://github.com/iago-suarez/ELSED | `1878213b2f5f06a9261d8b1838f53d48e5fd128d` | Apache-2.0 Git submodule `elsed/`; source only, no weights or build |
| LINEA line detector | https://github.com/SebastianJanampa/LINEA | `475c5ceea64114a48495c15888094e12f1a2d267` | Apache-2.0 Git submodule `linea/`; weights from `SebastianJanampa/storage` release LINEA |
| MINIMA (comparison arm) | https://github.com/LSXI7/MINIMA | `796e7721174f9f829b79b3702bf8c2ae9a3d447a` | Apache-2.0 Git submodule `minima/` |
| XoFTR (comparison arm) | https://github.com/OnderT/xoftr | `e0fbea431b30be9742effbf5577c90aa8eb938f9` | Apache-2.0 Git submodule `xoftr/` |
| Depth Anything V2 Small | https://github.com/DepthAnything/Depth-Anything-V2 | `a561b849ebae10a6f5ef49e26c83cbbcd36c71bf` | Apache-2.0 Small source submodule `depth_anything_v2/`; weights user-provided |
| MapAnything | https://github.com/facebookresearch/map-anything | `3d10cf7a3016fc0f9bb13a071ee66c47b10be0d9` | Apache-2.0 source submodule `map_anything/`; use Apache checkpoint only |
| DINOv2 | https://github.com/facebookresearch/dinov2 | See `dinov2/UPSTREAM_COMMIT.txt` | Apache-2.0 source copy in `dinov2/`; public ViT-S/14 weight in Git LFS |

DaD and DeDoDe are detector candidates. Descriptors come from DINOv2/DINOv3. LightGlue was removed on user request; TensorGraphX currently uses mutual nearest-neighbor matching.

## Removed

| Component | Removed on | Reason |
|---|---|---|
| SuperPoint (`rpautrat/SuperPoint`, submodule, rev `1411bbd6`) | 2026-09-26 | Retired in favour of the DeDoDe detector. The upstream code is MIT, but the detector weights derive from a TensorFlow checkpoint whose provenance was not established for commercial use, so the whole component was dropped rather than audited. |
