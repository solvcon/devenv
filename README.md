**UNDER DEVELOPMENT**

# SOLVCON Development Environment

This project provides a reference runtime environment for developing SOLVCON
and related projects to reduce unnecessary misunderstandings.  It supports the
following features:

1. Support ubuntu and macOS.
2. Manage dependencies in the source-code level.  It may build all dependencies
   from source and retain the source code, so that a debugger can read it.
3. Allow building a selected set of packages from repository / master.  The
   minimal set includes cpython, numpy, and pybind11.
4. Allow multiple copies of the runtime environment and build at the same time.
   At least support two flavors: release and debug.

The environment consists of scripts for building dependencies and managing
them.  More information will be added as the project becomes more complete.


## Pre-requisite

By using the following command to setup all necessary environment variables:

```
source scripts/init
```


## Usage

By invoking this one command should bring you the whole SOLVCON stack:

```bash
./bin/build-application-solvcon-devenv.sh
```

You may use the management tool `devenv` to build the target package you need from source.
By placing the command to see the details of usage:

```
devenv
```


## Development

### Build Scripts
We strongly suggest you to enable shared library build by default in your
package build script, because it is expected to launch a lot of applications
built by `devenv` for `devenv` users, and the launched toolchain may need
significant memory. Enabling shared library to build your package will provide
more flexibility and saves significant memory.


<!-- vim: set ff=unix ft=markdown fenc=utf8 sw=2 tw=79: -->
