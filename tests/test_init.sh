#!/bin/bash
. ../scripts/init

echo "*** test file: $(basename ${BASH_SOURCE[0]})"

test_use_cmd() {
  devenv add foo
  devenv use foo
  assertEquals ${DEVENVFLAVOR} "foo"
  devenv off
  devenv del foo
  devenv use foo
  assertNotContains "${DEVENVFLAVOR}" "foo"
}

# Load and run shUnit2.
. ./shunit2/shunit2
