#!/bin/bash

DEFCONFIG=qemu_aarch64_virt_uutils_coreutils_defconfig

if [ "$#" -ge 1 ]; then
   DEFCONFIG=$1
fi

# Prepare
set -e
. "$HOME/.cargo/env"

echo "Using config $DEFCONFIG"
cp -v "configs/$DEFCONFIG" buildroot/configs

# Apply config
cd buildroot
make "$DEFCONFIG"

# Build
export FORCE_UNSAFE_CONFIGURE=1
make
cd -

# Pack
tar -czf images.tar.gz -C buildroot/output/images Image rootfs.ext2 rootfs.ext4
