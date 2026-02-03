#!/usr/bin/env bash
set -euo pipefail

mkdir -p third_party
cd third_party

# Isaac Gym
if [ ! -d "isaacgym" ]; then
    wget https://developer.nvidia.com/isaac-gym-preview-4 -O isaac-gym-preview-4.tar.gz
    tar -xf isaac-gym-preview-4.tar.gz
    rm isaac-gym-preview-4.tar.gz
    find isaacgym/python -type f -name "*.py" -exec sed -i 's/np\.float/np.float32/g' {} +
fi

cd ../
# editable install
uv pip install -e third_party/isaacgym/python/
# HoST's environment
#uv pip install -e rsl_rl/
#uv pip install -e legged_gym/
