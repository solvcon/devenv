#!/usr/bin/env bash
. ${DEVENVROOT}/scripts/func.d/bash_utils

test_display_type() {
  expected="display is a function"
  actual=$(type display | grep "is a")
  assertEquals "${expected}" "${actual}"
}

test_display() {
  expected="devenv shunit2 unittest"
  actual=$(display 'devenv shunit2 unittest')
  assertEquals "${expected}" "${actual}"
}

test_display_e() {
  expected_stdin=""
  expected_return_code=87
  actual_stdin=$(display -e 'devenv shunit2 unittest')
  actual_return_code="$?"
  assertEquals "${expected_return_code}" "${actual_return_code}"
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

  # SETUP
  mkdir ${tmp_flavor}

  actual=$(get_list flavor)
  assertEquals "${flavor_name}" "${actual}"

  # TEARDOWN
  rmdir ${tmp_flavor}
}

# Load and run shUnit2.
. ./shunit2/shunit2

# vim: set et nu nobomb fenc=utf8 ft=sh ff=unix sw=2 ts=2:
