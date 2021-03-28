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

source $PREFIX/bin/activate
conda config --set channel_priority strict
conda config --append channels Semi-ATE

if [ `uname -m` == "x86_64" ]
then
#   mamba create -n _spyder_  _spyder_ -y
  mamba create -n _spyder_  -c conda-forge/label/beta spyder=5 ffmpeg -y
fi

# mamba create -n maxiconda maxiconda -y
mamba create -n maxiconda numpy -y

echo ">>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>> end : post-install <<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<"
