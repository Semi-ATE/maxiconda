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
echo "list of packages in base environment"
conda list 
echo "dry-run of removing pip"
conda remove pip --dry-run
echo "create empty _spyder_ environment"
conda create -n _spyder_
conda activate _spyder_
conda list


#conda install -c conda-forge/label/beta spyder=5

echo ">>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>> end : post-install <<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<"
