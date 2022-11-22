#!/usr/bin/env bash

set -xe
echo "***** Start: Building Maxiconda installer V$MAXICONDA_VERSION *****"

function CorrectAppleName() {
    local NAME_PARTS=($(echo $1 | tr "-" "\n"))
    local NEW_NAME="${NAME_PARTS[0]}"
    unset NAME_PARTS[0]
    for i in "${NAME_PARTS[@]}"
    do
        if [ "$i" == "MacOSX" ]; then
            NEW_NAME="${NEW_NAME}-MacOS"
        else
            NEW_NAME="${NEW_NAME}-$i"
        fi
    done
    echo $NEW_NAME
}

CONSTRUCT_ROOT="${CONSTRUCT_ROOT:-$PWD}"

cd $CONSTRUCT_ROOT

# Constructor should be latest for non-native building
# See https://github.com/conda/constructor
echo "***** Install constructor *****"
# conda install -y "constructor>=3.1.0" jinja2 -c conda-forge -c defaults --override-channels
conda install -y constructor jinja2 -c conda-forge --override-channels

if [[ "$(uname)" == "Darwin" ]]; then
    conda install -y coreutils -c conda-forge -c defaults --override-channels
elif [[ "$(uname)" == MINGW* ]]; then
    conda install -y "nsis=3.01" -c conda-forge -c defaults --override-channels
fi
# pip install git+git://github.com/conda/constructor@8c0121d3b81846de42973b52f13135f0ffeaddda#egg=constructor --force --no-deps
# pip install git+git://github.com/conda/constructor#egg=constructor --force --no-deps
conda list

echo "***** Make temp directory *****"
if [[ "$(uname)" == MINGW* ]]; then
   TEMP_DIR=$(mktemp -d --tmpdir=C:/Users/RUNNER~1/AppData/Local/Temp/);
else
   TEMP_DIR=$(mktemp -d);
fi

echo "***** Copy file for installer construction *****"
cp -R maxiconda $TEMP_DIR/
cp LICENSE $TEMP_DIR/

ls -al $TEMP_DIR

if [[ $(uname -m) != "$ARCH" ]]; then
    if [[ "$ARCH" == "arm64" ]]; then
        CONDA_SUBDIR=osx-arm64 conda create -n micromamba micromamba=0.6.5 -c https://conda-web.anaconda.org/conda-forge --yes
        EXTRA_CONSTRUCTOR_ARGS="$EXTRA_CONSTRUCTOR_ARGS --conda-exe $CONDA_PREFIX/envs/micromamba/bin/micromamba --platform osx-arm64"
    fi
fi

echo "***** Construct the installer *****"
echo "constructor $TEMP_DIR/maxiconda/ --output-dir $TEMP_DIR $EXTRA_CONSTRUCTOR_ARGS"
constructor $TEMP_DIR/maxiconda/ --output-dir $TEMP_DIR $EXTRA_CONSTRUCTOR_ARGS

echo "***** Generate installer hash *****"
cd $TEMP_DIR
if [[ "$(uname)" == MINGW* ]]; then
   EXT=exe;
else
   EXT=sh;
fi
# This line will break if there is more than one installer in the folder.
INSTALLER_PATH=$(find . -name "maxiconda*.$EXT" | head -n 1)
HASH_PATH="$INSTALLER_PATH.sha256"
sha256sum $INSTALLER_PATH > $HASH_PATH

echo "***** Move installer and hash to build folder *****"
mkdir -p $CONSTRUCT_ROOT/build
mv $INSTALLER_PATH $CONSTRUCT_ROOT/build/
mv $HASH_PATH $CONSTRUCT_ROOT/build/

echo "***** MacOSX --> MacOS *****"
for file_name in $(ls "$CONSTRUCT_ROOT/build");
do
    corrected_name=$(CorrectAppleName $file_name)
    if [ "$file_name" != $corrected_name ]; then
        echo "$CONSTRUCT_ROOT/build/$file_name --> $CONSTRUCT_ROOT/build/$corrected_name"
        mv "$CONSTRUCT_ROOT/build/$file_name" "$CONSTRUCT_ROOT/build/$corrected_name"
    fi
done


echo "***** Done: Building Maxiconda installer *****"
cd $CONSTRUCT_ROOT
