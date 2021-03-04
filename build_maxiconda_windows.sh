conda install posix --yes
echo "MAXICONDA_VERSION = $MAXICONDA_VERSION"
echo "MAXICONDA_NAME = $MAXICONDA_NAME"
source scripts/build.sh
source scripts/test.sh
