FROM nvidia/cuda:12.8.0-devel-ubuntu22.04

# 環境変数の設定
ENV DEBIAN_FRONTEND=noninteractive
ENV PYTHONUNBUFFERED=1

# システムパッケージの更新とインストール
RUN apt-get update && apt-get install -y \
    python3.10 \
    python3.10-dev \
    python3-pip \
    git \
    wget \
    curl \
    build-essential \
    libgl1-mesa-glx \
    libglib2.0-0 \
    libsm6 \
    libxext6 \
    libxrender-dev \
    libgomp1 \
    libosmesa6-dev \
    patchelf \
    && rm -rf /var/lib/apt/lists/*

# Setup uv
COPY --from=ghcr.io/astral-sh/uv:latest /uv /uvx /bin/
ENV UV_LINK_MODE=copy
RUN echo 'eval "$(uv generate-shell-completion bash)"' >> ~/.bashrc

# 作業ディレクトリの設定
WORKDIR /workspace

# pyproject.tomlとuv.lockをコピー
#COPY pyproject.toml uv.lock .python-version ./
COPY . .

# uv syncで依存関係をインストール
RUN uv sync && bash setup_third_party.sh

# ソースコードをコピー

# 実行権限を付与
#RUN chmod +x effective.sh

# デフォルトコマンド
#CMD ["uv", "run", "python", "main.py"]
CMD ["bash"]
