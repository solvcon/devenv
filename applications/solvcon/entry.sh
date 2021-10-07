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
MINICONDA_DIR="${SCSRC_WORKING}/miniconda"

export PATH="${SCSRC}:${MINICONDA_DIR}/bin:${PATH}"

mkdir -p ${SCSRC_WORKING}

# prepare miniconda
# please note contrib/conda.sh will use python 3.6 if you want to install
# paraview with this conda 3.6 python, this issue may happen to you github
# https://github.com/conda-forge/paraview-feedstock/issues/27 by using 3.8
# python conda this issue is resolved by the recompiled paraview package and
# the corresponding libraries
#
# install paraview via conda-forge:
#     conda install -c conda-forge paraview
case $(uname) in
  Linux*)
    platform=Linux
    ;;
  Darwin*)
    platform=MacOSX
    ;;
esac
curl -L https://repo.continuum.io/miniconda/Miniconda3-latest-${platform}-x86_64.sh --output ${SCSRC_WORKING}/miniconda.sh

bash ${SCSRC_WORKING}/miniconda.sh -b -p ${MINICONDA_DIR}
conda config --set always_yes yes
conda update -q conda

# create virtual env by conda
conda create -p ${SCSRC_WORKING}/venv-conda --no-default-packages -y python
source activate ${SCSRC_WORKING}/venv-conda

# prepare all packages to build SOLVCON
source ${DEVENVAPPBUILDSRC}/conda.sh
source ${DEVENVAPPBUILDSRC}/build-pybind11-in-conda.sh

DEVENVFLAVOR_SUB=${DEVENVFLAVOR}
source ${DEVENVROOT}/scripts/init
devenv use ${DEVENVFLAVOR_SUB}
VERSION=3.0.6 devenv build gmsh

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


# A workaround to use packages built or managed by conda.  We could abandon
# this workaround when devenv is fully integrated and used for SOLVCON
echo
echo
echo "Select the devenv flavor we used to build SOLVCON:"
echo ""
echo "source scripts/init"
echo "devenv use ${DEVENVFLAVOR}"
echo ""
echo "Re-launch SOLVCON by the following commands after picking up your devenv flavor:"
echo ""
echo 'export PATH=$DEVENVCURRENTROOT/application-solvcon/solvcon-working/miniconda/bin:$PATH'
echo 'source activate $DEVENVCURRENTROOT/application-solvcon/solvcon-working/venv-conda'
echo ""
echo "Your SOLVCON source:"
echo "${SCSRC}"
echo

