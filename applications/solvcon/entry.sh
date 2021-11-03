#!/usr/bin/env bash
#
# Usage:
#   source <this script>
#

if [ -z "${DEVENVFLAVOR}" ]
then
  SOLVCON_PROJECT=${HOME}/solvcon
else
  SOLVCON_PROJECT=${DEVENVAPP}
fi

SCSRC="${SOLVCON_PROJECT}/solvcon"
SCSRC_WORKING="${SOLVCON_PROJECT}/solvcon-working"

export PATH="${SCSRC}:${PATH}"
# so python and pip could be found and used
export PATH=${DEVENVCURRENTROOT}/usr/bin:${PATH}

mkdir -p ${SCSRC_WORKING}

DEVENVFLAVOR_SUB=${DEVENVFLAVOR}
source ${DEVENVROOT}/scripts/init
# just in case
unset VERSION
unset APP_UPSTREAM_PROJECT_ROOT
devenv use ${DEVENVFLAVOR_SUB}
# openssl will be used by python and cmake
# bz2 will be used by solvcon (via python)
devenv build openssl
devenv build bzip2
VERSION=3.8 devenv build python
devenv build cmake
# scotch will be used later by libmarch
# cmake will be used for building scotch
SYNCGIT="yes" devenv build scotch

# prepare all packages to build SOLVCON
pip3 install nose boto paramiko netCDF4 numpy
devenv build pybind11
devenv build gmsh
devenv build hdf

python_exe_base=$(which python3)
PYTHON_EXE=${python_exe_base} devenv build cython

pushd ${SCSRC}
# make libmarch.so and SOLVCON
make
make install

# test built SOLVCON
nosetests --with-doctest
nosetests ftests/gasplus/*
popd

echo "======================================="
echo "Completed unit tests and function tests"
echo "======================================="

echo "======================================="
echo "Start to run Sod tube test"
echo "======================================="
# basic example
pushd ${SCSRC}/sandbox/gas/tube
./go run
popd


echo
echo
echo "Select the devenv flavor we used to build SOLVCON:"
echo
echo "source scripts/init"
echo "devenv use ${DEVENVFLAVOR}"
echo
echo
echo "Your SOLVCON source:"
echo "${SCSRC}"
echo

