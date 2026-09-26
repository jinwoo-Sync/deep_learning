# SAM3 on Ubuntu CUDA

Meta official `sam3/` source runs only through this independent `uv` project's `.venv`. Do not install SAM3 with global `pip` or run it from another model's environment.

```bash
docker build -f envs/sam3_ubuntu/Dockerfile -t tensorgraphx-sam3:cuda .
docker run --rm --gpus all -v "$PWD/model_weights/sam3/official:/weights:ro" tensorgraphx-sam3:cuda
```

The official checkpoint must be approved and downloaded separately. No Ubuntu host was provided, so the image has not been built and CUDA inference has not been tested. The host needs NVIDIA Container Toolkit and a CUDA-capable GPU. The checkpoint remains outside the image and out of Git.
