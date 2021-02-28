#!/usr/bin/env bash

set -ex

echo "***** Start: Testing Maxiconda installer *****"

export CONDA_PATH="$HOME/maxiconda"

CONSTRUCT_ROOT="${CONSTRUCT_ROOT:-$PWD}"

cd ${CONSTRUCT_ROOT}

echo "***** Get the installer *****"
ls build/
if [[ "$(uname)" == MINGW* ]]; then
   EXT=exe;
else
   EXT=sh;
fi
INSTALLER_PATH=$(find build/ -name "maxiconda*.$EXT" | head -n 1)

chmod +x $INSTALLER_PATH
if [[ "$(uname)" == MINGW* ]]; then
  echo "***** Run the installer *****"
  echo "start /wait \"\" ${INSTALLER_PATH} /InstallationType=JustMe /RegisterPython=0 /S /D=$(cygpath -w $CONDA_PATH)" > install.bat
  cmd.exe /c install.bat

  echo "***** activate conda *****"
  source $CONDA_PATH/Scripts/activate
  conda.exe config --set show_channel_urls true

  echo "***** Print conda info *****"
  conda.exe info
  conda.exe list

  echo "***** Check if we are bundling packages from msys2 or defaults *****"
  conda.exe list | grep defaults && exit 1
  conda.exe list | grep msys2 && exit 1

  echo "***** Check if we can install a package which requires msys2 *****"
  conda.exe install r-base --yes --quiet
  conda.exe list
else
  echo "***** Run the installer *****"
  bash $INSTALLER_PATH -b -p $CONDA_PATH

  echo "***** activate conda *****"
  source $CONDA_PATH/bin/activate

  echo "***** Print conda info *****"
  conda info
  conda list
fi

echo "***** Test the installer *****"

# 2020/09/15: Running conda update switches from pypy to cpython. Not sure why
# echo "***** Run conda update *****"
# conda update --all -y

echo "***** Python path *****"
python -c "import sys; print(sys.executable)"
python -c "import sys; assert 'maxiconda' in sys.executable"

echo "***** Print system informations from Python *****"
python -c "print('Hello Maxiconda !')"
python -c "import platform; print(platform.architecture())"
python -c "import platform; print(platform.system())"
python -c "import platform; print(platform.machine())"
python -c "import platform; print(platform.release())"

echo "***** Done: Testing installer *****"
