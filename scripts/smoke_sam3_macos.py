"""Smoke test the official SAM3 image weights through the isolated MLX runtime."""
from pathlib import Path

from PIL import Image
from sam3_mlx import build_sam3_image_model
from sam3_mlx.model.sam3_image_processor import Sam3Processor

ROOT = Path(__file__).resolve().parents[1]
CHECKPOINT = ROOT / "model_weights/sam3/mlx/model.safetensors"
IMAGE = ROOT / "sam3/assets/images/truck.jpg"

if not CHECKPOINT.is_file():
    raise SystemExit("Missing MLX weights. Run scripts/convert_sam3_mlx.py first.")
model = build_sam3_image_model(checkpoint_path=CHECKPOINT, load_from_HF=False)
processor = Sam3Processor(model)
state = processor.set_image(Image.open(IMAGE).convert("RGB"))
output = processor.set_text_prompt("truck", state)
scores = output["scores"]
masks = output["masks"]
if len(scores) < 1 or masks.shape[0] < 1:
    raise SystemExit("SAM3 produced no truck mask.")
print(f"SAM3 Mac GPU OK: score={float(scores[0]):.6f}, masks={tuple(masks.shape)}")
