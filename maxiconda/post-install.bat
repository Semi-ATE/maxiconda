# Copyright (c) Semi-ATE
# Distributed under the terms of the BSD 3-Clause License

# file : post-install.bat

# 
# Once the maxiconda installer did run (and thus created the 'base' envriornment),
# this script is (on Windows) responsible to create the '_spyder_' and 'maxiconda'
# environments with the respectively named conda metapackages from the Semi-ATE channel.
#
@echo off
echo ">>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>> start : post-install <<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<"

call %PREFIX%\maxiconda\Scripts\activate.bat
call conda config --set channel_priority strict
call conda config --append channels Semi-ATE

REM call mamba create -n _spyder_ _spyder_ -y
call mamba create -n _spyder_ -c conda-forge/label/beta spyder=5 ffmpeg -y

REM call mamba create -n maxiconda maxiconda -y
call mamba create -n maxiconda numpy ipython -y

echo ">>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>> end : post-install <<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<"
