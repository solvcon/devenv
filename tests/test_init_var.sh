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
  # shunit2 prepends the runtime PATH.  Remove it before testing.
  testpath=${PATH}
  testpath=${testpath#/tmp/shunit.*:}  # Remove shunit tmp in Linux
  testpath=${testpath#/var/folders/*shunit.*:}  # Remove shunit tmp in macos
  assertEquals "${DEVENVPATH_BACKUP}" "${testpath}"
}

test_devenvprefix() {
  assertEquals "${DEVENVPREFIX}" ""
}

test_devenvdlroot() {
  assertEquals ${DEVENVDLROOT} ${expected_devenvroot}/var/downloaded
}

# Load and run shUnit2.
. ./shunit2/shunit2
