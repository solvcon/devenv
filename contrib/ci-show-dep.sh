#!/usr/bin/bash
source ${DEVENV_WORKSPACE}/scripts/init

devenv use prime
devenv show
export

which gcc
gcc --version

which cmake
cmake --version

which gmsh
