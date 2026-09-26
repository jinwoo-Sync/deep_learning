# DINOv3 weights

No checkpoint is present yet. Meta provides download URLs after access is
approved through the [official DINOv3 model page](https://github.com/facebookresearch/dinov3#pretrained-models).
TensorGraphX currently uses the ViT-S/16 backbone (`dinov3_vits16`). Put the
corresponding `.pth` checkpoint here when available, and pass its path with
`--dinov3-weights`. Checkpoint files in this directory are configured for Git
LFS; retain `dinov3/LICENSE.md` whenever distributing them.
