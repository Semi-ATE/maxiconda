#!/usr/bin/env bash
# Build maxiconda installers for Linux
# on various architectures (aarch64, x86_64, ppc64le)
# Notes:
# It uses the qemu-user-static [1] emulator to enable
# the use of containers images with different architectures than the host
# [1]: https://github.com/multiarch/qemu-user-static/
# See also: [setup-qemu-action](https://github.com/docker/setup-qemu-action)
set -exou

# Check parameters
ARCH=${ARCH:-aarch64}
DOCKER_ARCH=${DOCKER_ARCH:-arm64v8}
export TARGET_PLATFORM=${TARGET_PLATFORM:-linux-aarch64}
DOCKERIMAGE=${DOCKERIMAGE:-condaforge/linux-anvil-aarch64}
MAXICONDA_VERSION=${MAXICONDA_VERSION:-0.0.0}
export CONSTRUCT_ROOT=/construct

echo "============= Create build directory ============="
mkdir -p build/
chmod 777 build/

echo "============= Enable QEMU ============="
# Enable qemu in persistent mode
docker run --rm --privileged multiarch/qemu-user-static \
  --reset --credential yes --persistent yes

echo "============= Build the installer ============="
docker run --rm -v "$(pwd):/construct" \
  -e CONSTRUCT_ROOT -e TARGET_PLATFORM -e ARCH -e MAXICONDA_NAME -e MAXICONDA_VERSION \
  ${DOCKERIMAGE} /construct/scripts/build.sh

echo "============= Test the installer ============="
#for TEST_IMAGE_NAME in "ubuntu:20.04" "ubuntu:19.10" "ubuntu:16.04" "ubuntu:18.04" "centos:7" "debian:buster"; do
if [[ $ARCH == "x86_64" ]]; then
  for TEST_IMAGE_NAME in "ubuntu:20.04"; do
    echo "============= Test installer on ${TEST_IMAGE_NAME} ============="
    docker run --rm -v "$(pwd):/construct" -e CONSTRUCT_ROOT \
      "${DOCKER_ARCH}/${TEST_IMAGE_NAME}" /construct/scripts/test.sh
  done
fi
