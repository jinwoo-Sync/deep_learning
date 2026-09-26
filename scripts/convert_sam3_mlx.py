"""Convert the locally downloaded official SAM3 checkpoint for Apple MLX."""
from pathlib import Path

from sam3_mlx.convert import convert, save_weights

ROOT = Path(__file__).resolve().parents[1]
SOURCE = ROOT / "model_weights/sam3/official"
DESTINATION = ROOT / "model_weights/sam3/mlx"

if not (SOURCE / "sam3.pt").is_file():
    raise SystemExit("Missing official checkpoint. Run scripts/fetch_sam3.sh first.")
weights = convert(SOURCE)
save_weights(DESTINATION, weights)
print(f"Converted {len(weights)} tensors to {DESTINATION / 'model.safetensors'}")
