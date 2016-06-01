#!/bin/bash

## dependencies
source test/common.sh

## target
TARGET=test/check

## test suite
suite () {
  ## unit test
  run-test $TARGET "`cat <<-SRC

#include <stdio.h>
#include <check/check.h>
int main (void) {
  CHECK(0);
  return 0;
}

SRC`"
  return $?
}

suite
expect "$? > 0"
