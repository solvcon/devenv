#!/bin/bash
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

# Load and run shUnit2.
. ./shunit2/shunit2

# vim: set et nu nobomb fenc=utf8 ft=sh ff=unix sw=2 ts=2:
