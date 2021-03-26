# Copyright (c) Semi-ATE
# Distributed under the terms of the BSD 3-Clause License

# file : post-install.bat

# 
# Once the maxiconda installer did run (and thus created the 'base' envriornment),
# this script is (on Windows) responsible to create the '_spyder_' and 'maxiconda'
# environments with the respectively named conda metapackages from the Semi-ATE channel.
#

@echo off
setlocal enabledelayedexpansion
echo maxclients !PYTHON_PATH! > bla.cfg
