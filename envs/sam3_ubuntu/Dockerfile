FROM nvidia/cuda:12.8.1-cudnn-runtime-ubuntu24.04
COPY --from=ghcr.io/astral-sh/uv:0.9.28 /uv /uvx /bin/

ENV DEBIAN_FRONTEND=noninteractive
RUN apt-get update && apt-get install -y --no-install-recommends \
    python3 python3-venv ca-certificates \
    && rm -rf /var/lib/apt/lists/*

COPY sam3 /opt/deep_learning/sam3
COPY envs/sam3_ubuntu/pyproject.toml /opt/deep_learning/envs/sam3_ubuntu/pyproject.toml
RUN uv sync --project /opt/deep_learning/envs/sam3_ubuntu --python 3.12

WORKDIR /work
CMD ["uv", "run", "--project", "/opt/deep_learning/envs/sam3_ubuntu", "python", "-c", "import torch, sam3; print('CUDA:', torch.cuda.is_available())"]
