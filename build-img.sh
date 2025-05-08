#!/bin/bash

DEFCONFIG=qemu_aarch64_virt_uutils_coreutils_defconfig

if [ "$#" -ge 1 ]; then
   DEFCONFIG=$1
fi

set -e
. "$HOME/.cargo/env"

echo "Add config $DEFCONFIG"
cp configs/"$DEFCONFIG" buildroot/configs/"$DEFCONFIG"

echo "Apply config $DEFCONFIG"
cd buildroot
make "$DEFCONFIG"

echo "Build"
export FORCE_UNSAFE_CONFIGURE=1
make
cd -

echo "Pack"
tar -czf images.tar.gz -C buildroot/output/  images
