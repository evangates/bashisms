#!/bin/bash

. lib/asserts.sh

TEST_DIR='tests'

find_tests() {
  find "$TEST_DIR" -type f -name "*.sh"
}

strip_test_dir() {
  local full_path="$1"
  printf "%s" "${full_path#$TEST_DIR/}"
}

format_test_path_to_name() {
  local test_path="$1"

  local script_name=$(basename "${test_path%.*}")
  local script_dir=$(dirname "$test_path")

  local test_name_prefix=$(strip_test_dir "$script_dir")

  local test_name=$(printf "%s - %s" "${test_name_prefix//\// - }" "${script_name//_/ }")

  printf "%s" "$test_name"
}

process_failure() {
  local test_name="$1"

  printf "TEST FAILURE: %s\n" "$test_name"
}

process_success() {
  local test_name="$1"

  printf "TEST SUCCESS: %s\n" "$test_name"
}

run_test() {
  local test_path="$1"
  local test_name="$(format_test_path_to_name "$test_path")"

  printf "running test: %s\n" "$test_name"

  $test_path

  if [ "$?" != "0" ]; then
    process_failure "$test_name"
  else
    process_success "$test_name"
  fi
}

for test in $(find_tests); do
  run_test "$test"
done


