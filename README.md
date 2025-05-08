# About

[![Build Status](https://gitlab.com/alexs-sh/uutils-coreutils-tester/badges/master/pipeline.svg)](https://gitlab.com/alexs-sh/uutils-coreutils-tester/-/commits/master)
[![License: MIT](https://img.shields.io/badge/License-MIT-yellow.svg)](https://opensource.org/licenses/MIT)

This project provides images with [uutils/coreutils](https://github.com/uutils/coreutils) included. Its main purpose is
to test uutils/coreutils and Buildroot changes on embedded devices and QEMU.
Since Buildroot development is patch-based, all these changes are also available on [Patchwork](https://patchwork.ozlabs.org/project/buildroot/patch/20250402165913.39797-2-shirokovalexs@gmail.com).

## QEMU

Here is an example of building and running AArch64 images in QEMU.

Build

```
./build-img.sh qemu_aarch64_virt_defconfig
```

Run QEMU with the generated kernel and rootfs.

```
qemu-system-aarch64 -M virt -cpu cortex-a53 -nographic -smp 1 \
    -kernel buildroot/output/images/Image \
    -append "rootwait root=/dev/vda console=ttyAMA0" \
    -netdev user,id=eth0 \
    -device virtio-net-device,netdev=eth0 \
    -drive file=buildroot/output/images/rootfs.ext2,if=none,format=raw,id=hd0 \
    -device virtio-blk-device,drive=hd0
```

Log in as `root` and run the `coreutils` command.

```
Welcome to Buildroot
buildroot login: root

# coreutils --help
coreutils 0.0.30 (multi-call binary)

Usage: coreutils [function [arguments...]]
       coreutils --list

Options:
      --list    lists all defined functions, one per row

Currently defined functions:

    [, b2sum, b3sum, base32, base64, basename, basenc, cat, cksum, comm,
    cp, csplit, cut, date, dd, df, dir, dircolors, dirname, du, echo, env,
    expand, expr, factor, false, fmt, fold, hashsum, head, join, link,
    ln, ls, md5sum, mkdir, mktemp, more, mv, nl, numfmt, od, paste, pr,
    printenv, printf, ptx, pwd, readlink, realpath, rm, rmdir, seq, sha1sum,
    sha224sum, sha256sum, sha3-224sum, sha3-256sum, sha3-384sum, sha3-
    512sum, sha384sum, sha3sum, sha512sum, shake128sum, shake256sum, shred,
    shuf, sleep, sort, split, sum, tac, tail, tee, test, touch, tr, true,
    truncate, tsort, unexpand, uniq, unlink, vdir, wc, yes
```
