# Upstream provenance

| Component | Source | Pinned revision | Storage |
|---|---|---|---|
| DINOv3 | https://github.com/facebookresearch/dinov3 | `6876159a11b4df116f30f667f8c9888617df0751` | Source copy in `dinov3/`, including upstream `LICENSE.md` |
| SuperPoint detector | https://github.com/magicleap/SuperGluePretrainedNetwork | `ddcf11f42e7e0732a0c4607648f9448ea8d73590` | Git submodule `superpoint/`, no copied source or weights in this repository |

The SuperPoint detector and `superpoint_v1.pth` are read from the upstream
submodule. The SuperGlue matching model is not used by TensorGraphX.
