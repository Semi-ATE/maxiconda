#!/bin/bash
# Build maxiconda installers for macOS 
# on various architectures (aarch64, x86_64)
# Notes:
# It uses the qemu-user-static [1] emulator to enable 
# the use of containers images with different architectures than the host
# [1]: https://github.com/multiarch/qemu-user-static/
# See also: [setup-qemu-action](https://github.com/docker/setup-qemu-action)
#
# Copyright (c) 2019-2021, conda-forge
#

set -e
set -x

echo "Installing a fresh version of Miniforge3."
MINIFORGE_URL="https://github.com/conda-forge/miniforge/releases/download/4.8.3-1"
MINIFORGE_FILE="Miniforge3-4.8.3-1-MacOSX-x86_64.sh"
curl -L -O "${MINIFORGE_URL}/${MINIFORGE_FILE}"
bash $MINIFORGE_FILE -b

echo "Configuring conda."
source ~/miniforge3/bin/activate root

export CONSTRUCT_ROOT=$PWD
mkdir -p build

bash scripts/build.sh
if [[ "$ARCH" == "$(uname -m)" ]]; then
  bash scripts/test.sh
fi
