#!/bin/bash
set -e

export FORCE_UNSAFE_CONFIGURE=1

cd buildroot

./support/testing/run-tests \
  -d ./test-dl \
  -o ./test-output \
  tests.package.test_rust.TestRust \
  tests.package.test_rust.TestRustBin \
  tests.package.test_rust.TestRustVendoring
