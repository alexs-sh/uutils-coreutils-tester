#!/bin/bash

DEFCONFIG=qemu_aarch64_virt_uutils_coreutils_defconfig
MODE="multicall"

if [ "$#" -ge 1 ]; then
   DEFCONFIG=$1
fi

if [ "$#" -gt 1 ]; then
   MODE=$2
fi

readonly BR_CONFIG=buildroot/configs/"$DEFCONFIG"

set -e
. "$HOME/.cargo/env"

echo "Add config $DEFCONFIG"
cp configs/"$DEFCONFIG" "$BR_CONFIG"

if [ "$MODE" == "non-multicall" ]; then
  echo "Disable multicall"
  echo "# BR2_PACKAGE_UUTILS_COREUTILS_MULTICALL is not set" >> "$BR_CONFIG"
fi

echo "Apply config $DEFCONFIG"
cd buildroot
make "$DEFCONFIG"

echo "Build"
export FORCE_UNSAFE_CONFIGURE=1
make
cd -

echo "Pack"
tar -czf images.tar.gz -C buildroot/output/  images
