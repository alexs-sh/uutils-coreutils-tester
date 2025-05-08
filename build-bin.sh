#!/bin/bash
set -e

VERSION=0.0.30
ARCHIVE=sources.tar.gz

if [ "$#" -lt 1 ]; then
  echo "Target is not specified"
  exit 1
else
  TARGET="$1"
fi

curl -o $ARCHIVE -L https://github.com/uutils/coreutils/archive/refs/tags/${VERSION}.tar.gz
tar xf $ARCHIVE

cd coreutils-${VERSION}
cargo build --release --target="${TARGET}"
cd -

tar cvzf binaries.tar.gz -C coreutils-${VERSION}/target/"${TARGET}"/release coreutils
