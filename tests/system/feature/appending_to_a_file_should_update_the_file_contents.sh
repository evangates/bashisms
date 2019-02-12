#!/bin/bash

FILE_NAME="foo.txt"
FILE_CONTENTS="file contents\n"

bdd_given() {
  echo "given a file named ${FILE_NAME}"
  cleanup
  touch "${FILE_NAME}"
}

bdd_when() {
  echo "appending to ${FILE_NAME}"
  echo -n "$FILE_CONTENTS" >> "$FILE_NAME"
}

bdd_then() {
  echo "should add the contents to $FILE_NAME"
  local expected="$FILE_CONTENTS"
  local actual="$(cat $FILE_NAME)"

  assertEquals "$actual" "$expected" "file contents"
}

cleanup() {
  rm -f "${FILE_NAME}"
}

bdd_given
bdd_when
bdd_then

result=$?

cleanup

exit $result