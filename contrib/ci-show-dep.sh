#!/usr/bin/env bash
set -eo pipefail
if [ -z "${DEVENV_WORKSPACE}" ]; then
  echo DEVENV_WORKSPACE is not available. Abort!
  exit 1
fi

source ${DEVENV_WORKSPACE}/scripts/init

devenv use prime
devenv show
export

which gcc
gcc --version

which cmake
cmake --version

which gmsh
