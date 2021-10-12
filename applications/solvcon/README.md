# SOLVCON Application
## TODO
The build script for `SOLVCON` is under development to build all stacks with `devevn`. Currently the build script is still using a mixed approach with `conda`. Our plan is to migrate each package from `conda` to `devenv` piece by piece. The following packages of the SOLVCON stack are still installed by `conda`:

- cmake
- setuptools
- pip
- sphinx
- ipython
- jupyter
- numpy
- hdf4
- netcdf4
- nose
- pytest
- paramiko
- boto
- graphviz

Refer to `conda.sh` to see how they are installed.
