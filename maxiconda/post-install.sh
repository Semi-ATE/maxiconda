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

CPU=`uname -m`
case $CPU in
    "x86_64")
        CPU_NAME="x86_64"
        ;;
    "aarch64")
        CPU_NAME="aarch64"
        ;;
    "ppc64le")
        CPU_NAME="ppc64le"
        ;;
    *)
        printf "WOOPS: CPU '%s' is not yet implemented...\\n" $OS
        exit 1
        ;;
esac

source $CONDA_PATH/bin/activate
conda config --set channel_priority strict
# conda config --append channels Semi-ATE

if [ "$CPU" == "x86_64" ]
then
#   mamba create -n _spyder_ _spyder_ -y
  mamba create -n _spyder_  -c conda-forge/label/beta spyder=5 spyder-remote-client -y
fi

# mamba create -n maxiconda maxiconda -y
mamba create -n maxiconda numpy

echo ">>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>> end : post-install <<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<"
