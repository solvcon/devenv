#!/bin/bash
#PBS -P <PROJECTSYSTEMCODE>
#PBS -N build_modmesh_env
#PBS -l select=1:ncpus=8:mpiprocs=8
#PBS -q <NODETYPE>
#PBS -j oe

# * this script is used to build the modmesh environment
# it should work directly in login node, or you can submit it to the queue system
# by using qsub command, for example:
# qsub -v DEVENVFLAVOR=mmenv twnia1_env.sh
# * you have to decide <PROJECTSYSTEMCODE>. check by command: get_su_balance
# * you have to decide <NODETYPE> to other node type, e.g. cf160, ct160, etc.

# * install devenv before running this script
if [ -f ~/devenv/scripts/init ]; then source ~/devenv/scripts/init; fi

module load gcc/11.2.0
export CC=/pkg/gcc/11.2.0/bin/gcc
export CXX=/pkg/gcc/11.2.0/bin/g++
# * download LLVM before running this script, for twnia1:
# https://download.qt.io/development_releases/prebuilt/libclang/libclang-release_120-based-linux-Rhel7.6-gcc5.3-x86_64.7z
export LLVM_INSTALL_DIR=~/libclang120

DEVENVFLAVOR=${DEVENVFLAVOR:-"mmenv"}
echo "deleting old flavor: ${DEVENVFLAVOR}"
devenv del ${DEVENVFLAVOR}
devenv use ${DEVENVFLAVOR}

export PKG_CONFIG_PATH="$(pkg-config --variable pc_path pkg-config)"
export PKG_CONFIG_PATH=$PKG_CONFIG_PATH:${DEVENVPREFIX}/lib64/pkgconfig
export PKG_CONFIG_PATH=$PKG_CONFIG_PATH:${DEVENVPREFIX}/lib/pkgconfig
export PKG_CONFIG_PATH=$PKG_CONFIG_PATH:${DEVENVPREFIX}/share/pkgconfig

devenv build libffi

devenv build xcb

devenv build openssl

CPPFLAGS=-I${DEVENVPREFIX}/lib/libffi-*/include devenv build python

devenv build cmake

pip3 cache purge

pip3 install ninja meson

devenv build libxkbcommon

devenv build qt

pip3 install numpy pytest flake8 matplotlib pybind11

# required by pyside6
pip3 install patchelf==0.15
PYSIDE_BUILD=1 MAKESPEC=ninja VERSION=$(qmake -query QT_VERSION) devenv build pyside6
