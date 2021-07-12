#!/bin/bash

test_namemunge() {
  mypath=path1
  assertEquals "$mypath" "path1"
  . ${DEVENVROOT}/scripts/env.d/devenv_impl
  namemunge mypath path2
  assertEquals "$mypath" "path2:path1"
  namemunge mypath path3 after
  assertEquals "$mypath" "path2:path1:path3"
}

test_nameremove() {
  mypath=path2:path1:path3
  assertEquals "$mypath" "path2:path1:path3"
  . ${DEVENVROOT}/scripts/env.d/devenv_impl
  nameremove mypath path1
  assertEquals "$mypath" "path2:path3"
  nameremove mypath path2
  assertEquals "$mypath" "path3"
}

# Load and run shUnit2.
. ./shunit2/shunit2

# vim: set et nu nobomb fenc=utf8 ft=bash ff=unix sw=2 ts=2:
