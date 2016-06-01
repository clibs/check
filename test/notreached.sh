#!/bin/bash

## dependencies
source test/common.sh

## target
TARGET=test/notreached

## test suite
suite () {
  ## unit test
  run-test $TARGET "`cat <<-SRC

#include <stdio.h>
#include <check/notreached.h>
int main (void) {
  NOTREACHED();
  printf("foo\n");
  return 0;
}

SRC`"
  return $?
}

suite
expect "$? > 0"
