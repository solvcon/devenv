# SOLVCON Development Environment

**UNDER DEVELOPMENT**

This project is a set of (Bourne again) shell scripts to align the environment
for developing SOLVCON and related projects in (Ubuntu) Linux and macOS.  The
features include:

1. Build dependencies from source and retain the source code for debugger.
2. Unprivileged installation.  No root permission is required.
3. Switchable environments.
4. Download source code from a repository or a tarball.

# Installation

Clone the repository to where you want to install, usually somewhere under your
home directory (e.g., `~/devenv`):

```bash
git clone git@github.com:solvcon/devenv.git ~/devenv
```

(Or use https:)

```bash
git clone https://github.com/solvcon/devenv ~/devenv
```

## Enabling

DEVENV requires bash and you need to turn it on in the shell:

```bash
source ~/devenv/scripts/init
```

It can be done automatically if you add the following line in the startup file
(`~/.bashrc` or `~/.bash_profile`):

```bash
if [ -f ~/devenv/scripts/init ]; then source ~/devenv/scripts/init; fi
```

# Usage

The tool uses a bash function `devenv` for all its commends:

```console
$ devenv
no active flavor: $DEVENVFLAVOR not defined

Usage: devenv [command]

Description:
    Tool to manage development environment in console

Variables:
    DEVENVROOT=/path/to
    DEVENVDLROOT=/path/to/var/downloaded
    DEVENVFLAVOR=

Commands:
    list   - list all available environments
    use    - activate an environment
    off    - deactivate the environment
    add    - create a new environment directory
    del    - delete a existing environment directory
    build  - build a package in the active environment
    launch - launch an application
```

There is no environment ("flavor") available in the beginning.  You need to
create one using `devenv add`:

```console
$ devenv add prime
create 'prime' dev environment.
```

The new flavor will be shown in the list:

```console
$ devenv list
prime
```

Adding a flavor does not enable it:

```console
$ devenv show
no flavor in use
```

Run the following command to use (enable) the flavor `prime` we just created:

```console
$ devenv use prime
now using 'prime'
$ devenv show
current flavor is prime
```

We can turn the flavor off:

```console
$ devenv off
'prime' to be turned off
$ devenv show
no flavor in use
```

# Development

## Build Scripts

Shared library (`-fPIC`) should be preferred in the build script for a package
because it saves memory for the applications using the dependency.

## Unit Tests

[shunit2](https://github.com/kward/shunit2) is used as the unit-test framework.
The test cases are placed in `<root>/tests`.  To run the unit tests, shunit2
needs to be initialized:

```bash
git submodule update --init
```

Go to `<root>/tests` and run the test driver:

```console
$ cd tests
$ ./runner.sh
```

You may also initialize the test library while cloning the repository:

```bash
git clone git@github.com:solvcon/devenv.git --recurse-submodules
```

<!-- vim: set ff=unix ft=markdown fenc=utf8 sw=2 tw=79: -->
