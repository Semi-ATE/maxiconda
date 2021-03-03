#!/bin/bash

set -e
set -x

echo "Installing a fresh version of maxiconda."
MAXICONDA_URL="https://github.com/conda-forge/maxiconda/releases/download/4.8.3-1"
MAXICONDA_FILE="maxiconda-4.8.3-1-MacOSX-x86_64.sh"
curl -L -O "${MAXICONDA_URL}/${MAXICONDA_FILE}"
bash $MAXICONDA_FILE -b

echo "Configuring conda."
source ~/maxiconda/bin/activate root

export CONSTRUCT_ROOT=$PWD
mkdir -p build

bash scripts/build.sh
if [[ "$ARCH" == "$(uname -m)" ]]; then
  bash scripts/test.sh
fi
