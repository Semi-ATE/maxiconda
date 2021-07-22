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

CPU=$(uname -m)
OS=$(uname)

case $OS in
    Darwin)
        case $CPU in
            x86_64)
                mamba create -n _spyder_ spyder -y
                mamba create -n maxiconda maxiconda -y
                ;;
            arm64)
                echo "MacOS-arm not yet operational"
                ;;
            *)
                echo "'$CPU' is not supported in  MacOS"
                ;;
        esac
        ;;
    Linux)
        case $CPU in
            x86_64)
                mamba create -n _spyder_ _spyder_ -y
                mamba create -n maxiconda maxiconda -y
                ;;
            aarch64)
                mamba create -n _spyder_ _spyder_ -y
                mamba create -n maxiconda maxiconda -y
                ;;
            *)
                echo "'$CPU' is not supported in Linux"
                ;;
        esac
        ;;
    *)
        echo "Unsupported Operating system"
        ;;
esac

echo ">>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>> end : post-install <<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<"
