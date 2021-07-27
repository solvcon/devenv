#!/bin/bash
expected_devenvroot="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"

test_devenvroot() {
  assertEquals ${DEVENVROOT} ${expected_devenvroot}
}

test_devenvflavor() {
  assertEquals "${DEVENVFLAVOR}" ""
}

test_devenvflavorroot() {
  assertEquals ${DEVENVFLAVORROOT} ${expected_devenvroot}/flavors
}

test_devenvlibrary_path_backup() {
  assertEquals "${DEVENVLIBRARY_PATH_BACKUP}" ""
}

test_devenvpath_backup() {
  # by running shunit2, the runtime PATH will be added /tmp/shunit.* at the
  # head of PATH string remove the shunit snippet to match the original PATH
  # backup
  assertEquals "${DEVENVPATH_BACKUP}" ${PATH#/tmp/shunit.*:}
}

test_devenvprefix() {
  assertEquals "${DEVENVPREFIX}" ""
}

test_devenvdlroot() {
  assertEquals ${DEVENVDLROOT} ${expected_devenvroot}/var/downloaded
}

# Load and run shUnit2.
. ./shunit2/shunit2
