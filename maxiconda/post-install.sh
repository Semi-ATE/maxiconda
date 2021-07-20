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

OS=$(uname)
CPU=$(uname -m)

if [ OS == "Darwin"]; then
   if [ CPU == "x86_64" ]; then
      mamba create -n _spyder_ _spyder_ -y
      mamba create -n maxiconda maxiconda -y
   elif [ CPU == "arm64" ]; then 
      # faking MacOS-arm64
      mamba create -n _spyder_ python -y
      mamba create -n maxiconda python -y
   else
      echo "Didn't recognize the '$CPU' processor ..."
   fi
elif [ OS == "Linux" ]; then
   if [ CPU == "x86_64" ]; then
      mamba create -n _spyder_ _spyder_ -y
      mamba create -n maxiconda maxiconda -y
   elif [ CPU == "aarch64" ]; then 
      # faking Linux-aarch64
      mamba create -n _spyder_ python -y
      mamba create -n maxiconda python -y
   else
      echo "Didn't recognize the '$CPU' processor ..."
   fi
else 
   echo "Didn't recognize the '$OS' operating system ..."
fi

echo ">>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>> end : post-install <<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<"
