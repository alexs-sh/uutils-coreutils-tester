#!/bin/bash

MODE=""
CONFIG_NAME=uutils-coreutils
CONFIG_FILE=${CONFIG_NAME}.config
CMD="./utils/test-pkg -p uutils-coreutils  -c uutils-coreutils.config"

if [ "$#" -ge 1 ]; then
   MODE=$1
fi


set -e
. "$HOME/.cargo/env"


cp -f configs/$CONFIG_FILE buildroot/
cd buildroot

if [ "$MODE" = "all" ]; then
  CMD+=" --all"
fi

export FORCE_UNSAFE_CONFIGURE=1
eval "$CMD"
