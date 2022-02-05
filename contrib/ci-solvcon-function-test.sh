#!/usr/bin/env bash
set -eo pipefail
if [ -z "${DEVENV_WORKSPACE}" ]; then
  echo DEVENV_WORKSPACE is not available. Abort!
  exit 1
fi

source ${DEVENV_WORKSPACE}/scripts/init

devenv use prime
devenv show

cd ${DEVENVCURRENTROOT}/application-solvcon/solvcon/
make SC_PURE_PYTHON=1 test_from_package
