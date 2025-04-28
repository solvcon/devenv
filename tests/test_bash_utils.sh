#!/bin/bash

echo "*** test file: $(basename ${BASH_SOURCE[0]})"

. ${DEVENVROOT}/scripts/func.d/bash_utils

test_display_type() {
  expected="devenv_display is a function"
  actual=$(type devenv_display | grep "is a")
  assertEquals "${expected}" "${actual}"
}

test_display() {
  expected="devenv shunit2 unittest"
  actual=$(devenv_display 'devenv shunit2 unittest')
  assertEquals "${expected}" "${actual}"
}

test_display_e() {
  expected_stdin=""
  expected_return_code=87
  actual_stdin=$(devenv_display -e 'devenv shunit2 unittest')
  actual_return_code="$?"
  assertEquals "${expected_return_code}" "${actual_return_code}"
}

test_get_list_type() {
  expected="get_list is a function"
  actual=$(type get_list | grep "is a")
  assertEquals "${expected}" "${actual}"
}

test_get_cmd_list() {
  expected=$(echo `${LS_PATH} -1 ../scripts/cmd.d/`)
  actual=$(get_list cmd)
  assertEquals "${expected}" "${actual}"
}

test_get_build_list() {
  expected=$(echo `${LS_PATH} -1 ../scripts/build.d/`)
  actual=$(get_list build)
  assertEquals "${expected}" "${actual}"
}

test_get_application_list() {
  expected=$(echo `${LS_PATH} -1 ../scripts/application.d/`)
  actual=$(get_list application)
  assertEquals "${expected}" "${actual}"
}

test_get_flavor_list() {
  flavor_name="shunit2"
  tmp_flavor="${DEVENVFLAVORROOT}/${flavor_name}"

  if [ -d ${tmp_flavor} ] ; then
    echo "${tmp_flavor} already exists; cannot test"
    exit
  fi

  assertNotContains "${actual}" "${flavor_name}"

  # SETUP
  mkdir -p "${DEVENVFLAVORROOT}"
  # Note: do NOT add -p.  Make it fail if the directory already exists.
  mkdir "${tmp_flavor}"

  actual=$(get_list flavor)
  assertContains "${actual}" "${flavor_name}"

  # TEARDOWN
  rmdir "${tmp_flavor}"
}

# Load and run shUnit2.
. ./shunit2/shunit2

# vim: set et nu nobomb fenc=utf8 ft=sh ff=unix sw=2 ts=2:
