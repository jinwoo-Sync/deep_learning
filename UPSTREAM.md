# Upstream provenance

| Component | Source | Pinned revision | Storage |
|---|---|---|---|
| DINOv3 | https://github.com/facebookresearch/dinov3 | `6876159a11b4df116f30f667f8c9888617df0751` | Source copy in `dinov3/`, including upstream `LICENSE.md` |
| SuperPoint detector | https://github.com/rpautrat/SuperPoint | `1411bbd68c50163555d39c1b26e9e046ebd48f27` | MIT Git submodule `superpoint/`; PyTorch `superpoint_pytorch.py` and `weights/superpoint_v6_from_tf.pth` |
| DINOv2 | https://github.com/facebookresearch/dinov2 | See `dinov2/UPSTREAM_COMMIT.txt` | Apache-2.0 source copy in `dinov2/`; public ViT-S/14 weight in Git LFS |

The SuperPoint detector and `superpoint_v6_from_tf.pth` are read from the upstream MIT submodule. The SuperGlue matching model is not used by TensorGraphX.
