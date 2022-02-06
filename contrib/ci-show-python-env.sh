#!/usr/bin/env bash
set -eo pipefail
if [ -z "${DEVENV_WORKSPACE}" ]; then
  echo DEVENV_WORKSPACE is not available. Abort!
  exit 1
fi

source ${DEVENV_WORKSPACE}/scripts/init

devenv use prime
devenv show
which python3
python3 --version
python3 -c 'import numpy ; print("numpy.__version__:", numpy.__version__)'
python3 -c 'import sys ; print(sys.path)'

echo "==============="
echo "python globals:"
python3 -c 'import numpy, solvcon ; print(globals())'
echo

echo "==============="
echo "python locals:"
python3 -c 'import numpy, solvcon ; print(locals())'
echo
