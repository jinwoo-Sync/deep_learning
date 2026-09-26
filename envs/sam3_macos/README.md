# SAM3 on Apple Silicon

**Always use this independent `uv` project and its `.venv`; never install into global Python or another model environment.**

```bash
uv sync --project envs/sam3_macos --python 3.13
uv run --project envs/sam3_macos python -c 'import sam3_mlx; print(sam3_mlx.__version__)'
```

Python 3.13.15 and `sam3-mlx==0.1.1` installed successfully. The import check from the sandbox failed with `No Metal device available`; the unsandboxed check was interrupted. There is no validated inference result. Official `facebook/sam3` checkpoint access is denied pending Hugging Face approval. Do not invoke the package's automatic community checkpoint download in place of the gated official source. The official checkpoint, when approved, belongs in `model_weights/sam3/official/sam3.pt`; conversion to MLX and actual mask output still require separate verification. SAM3.1 multiplex tracking is outside this Mac image path.
