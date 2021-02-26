#!/bin/bash

set -e
set -x

echo "Installing a fresh version of Maxiforge3."
MAXIFORGE_URL="https://github.com/conda-forge/maxiforge/releases/download/4.8.3-1"
MAXIFORGE_FILE="Maxiforge3-4.8.3-1-MacOSX-x86_64.sh"
curl -L -O "${MAXIFORGE_URL}/${MAXIFORGE_FILE}"
bash $MAXIFORGE_FILE -b

echo "Configuring conda."
source ~/maxiforge3/bin/activate root

export CONSTRUCT_ROOT=$PWD
mkdir -p build

bash scripts/build.sh
if [[ "$ARCH" == "$(uname -m)" ]]; then
  bash scripts/test.sh
fi
