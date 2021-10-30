#!/bin/bash
conda install -y \
  python=3.8 \
  numpy hdf4 netcdf4 nose boto paramiko
lret=$?; if [[ $lret != 0 ]] ; then exit $lret; fi
