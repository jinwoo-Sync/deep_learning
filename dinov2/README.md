# DINOv2 inference source

Meta DINOv2 official source subset for ViT-S/14 backbone inference, from the commit in `UPSTREAM_COMMIT.txt`. The `dinov2/models`, `dinov2/layers`, and `dinov2/hub/backbones.py` files are copied from the official source. `hubconf.py` exports only `dinov2_vits14`, excluding unrelated later model families and training code. Code and DINOv2 weights are Apache-2.0; see `LICENSE` and https://github.com/facebookresearch/dinov2#license . The upstream model card is https://github.com/facebookresearch/dinov2/blob/main/MODEL_CARD.md .

TensorGraphX loads `torch.hub.load(<this directory>, "dinov2_vits14", source="local", pretrained=False)` and then applies the local ViT-S/14 state dict.
