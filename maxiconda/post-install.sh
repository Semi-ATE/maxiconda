#!/bin/bash

# Copyright (c) Semi-ATE
# Distributed under the terms of the BSD 3-Clause License

# file : post-install.sh

# 
# Once the maxiconda installer did run (and thus created the 'base' envriornment),
# this script is (on Linux and MacOS) responsible to create the '_spyder_' and 'maxiconda'
# environments with the respectively named conda metapackages from the Semi-ATE channel.
#

echo ">>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>> start : post-install <<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<"

source $CONDA_PATH/bin/activate
echo ">>>> conda info"
conda info
# echo ">>> conda create -n _spyder_ python=3.8"
# conda create -n _spyder_ python=3.8
# echo ">>> conda activate _spyder_"
# conda activate _spyder_
# echo ">>> conda list"
# conda list
# echo ">>> conda install -c conda-forge/label/beta spyder=5"
# conda install -c conda-forge/label/beta spyder=5 
# echo ">>> conda list"
# conda list
# echo ">>> conda env list"
# conda env list

echo ">>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>> end : post-install <<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<"
