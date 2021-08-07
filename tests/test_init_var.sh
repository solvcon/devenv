#!/bin/bash

echo "*** test file: $(basename ${BASH_SOURCE[0]})"

expected_devenvroot="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"

test_devenvroot() {
  assertEquals "${expected_devenvroot}" "${DEVENVROOT}"
}

test_devenvflavor() {
  # Check for existence.
  assertEquals foo ${DEVENVFLAVOR+foo}
}

test_devenvflavorroot() {
  assertEquals "${expected_devenvroot}/flavors" "${DEVENVFLAVORROOT}"
}

test_devenvcurrentroot() {
  # Check for existence.
  assertEquals foo "${DEVENVCURRENTROOT+foo}"
}

test_devenvlibrary_path_backup() {
  # Check for existence.
  assertEquals foo ${DEVENVLIBRARY_PATH_BACKUP+foo}
}

test_devenvpath_backup() {
  # shunit2 prepends the runtime PATH.  Remove it before testing.
  testpath=${PATH}
  testpath=${testpath#/tmp/shunit.*:}  # Remove shunit tmp in Linux
  testpath=${testpath#/var/folders/*shunit.*:}  # Remove shunit tmp in macos
  assertEquals "${DEVENVPATH_BACKUP}" "${testpath}"
}

test_devenvprefix() {
  assertEquals /dev/null ${DEVENVPREFIX}
}

test_devenvdlroot() {
  assertEquals ${expected_devenvroot}/var/downloaded ${DEVENVDLROOT}
}

# Load and run shUnit2.
. ./shunit2/shunit2
