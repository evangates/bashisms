#!/bin/bash

[ -n "${ASSERTS_VERSION:-}" ] && return 0
ASSERTS_VERSION='0.1'

ASSERT_SUCCESS=0
ASSERT_FAILURE=1
ASSERT_ERROR=2


assertEquals() {
  local actual="$1"
  local expected="$2"
  local failure_message="$3"

  if [ "$1" == "$2" ]; then
    # echo "SUCCESS"
    return $ASSERT_SUCCESS
  else
    if [ -n "${failure_message:-}" ]; then
      printf "FAILURE: expected '%s' to be '%s'\n" "$actual" "$expected"
    else
      printf "FAILURE: %s: expected '%s' to be '%s'\n" "$failure_message" "$actual" "$expected"
    fi

    return $ASSERT_FAILURE
  fi
}
declare -fx assertEquals