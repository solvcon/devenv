#!/usr/bin/env bash
source ${DEVENV_WORKSPACE}/scripts/init

devenv use prime
devenv show

cd ${DEVENVCURRENTROOT}/application-solvcon/solvcon/
make SC_PURE_PYTHON=1 test_from_package
