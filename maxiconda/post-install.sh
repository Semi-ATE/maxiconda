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
conda config --set channel_priority strict

echo ">>>>> conda info"
conda info 
echo ">>>>> conda config --get channels"
conda config --get channels
echo ">>>>> conda config --show channel_priority"
conda config --show channel_priority

echo ">>>>> mamba create -n _spyder_ -c conda-forge/label/beta spyder=5 spyder-remote-client -y"
mamba create -n _spyder_ -c conda-forge/label/beta spyder=5 spyder-remote-client -y

echo ">>>>> conda info"
conda info 
echo ">>>>> conda config --get channels"
conda config --get channels
echo ">>>>> conda config --show channel_priority"
conda config --show channel_priority


# conda config --append channels Semi-ATE
# conda config --set channel_priority strict

# echo ">>>> conda create -n _spyder_ -c conda-forge/label/beta spyder=5 spyder-remote-client -y > ./log 2>&1"
# conda create -n _spyder_ -c conda-forge/label/beta spyder=5 spyder-remote-client -y > ./log 2>&1
# echo ">>>> cat ./log"
# cat ./log
# echo ">>>> conda config --show"
# conda config --show



# echo ">>>> mamba create -n _spyder_ -c conda-forge/label/beta spyder=5 -y > ./log 2>&1"
# mamba create -n _spyder_ -c conda-forge/label/beta spyder=5 spyder-remote-client -y > ./log 2>&1
# echo ">>>> cat ./log"
# cat ./log
# echo ">>>>> mamba create -n maxiconda starz -y > ./log 2>&1"
# mamba create -n maxiconda starz -y > ./log 2>&1
# echo ">>>> cat ./log"
# cat ./log

echo ">>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>> end : post-install <<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<"
