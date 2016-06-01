#!/bin/bash

## dependencies
source test/common.sh

## target
TARGET=test/dcheck

## test suite
suite () {
  ## unit test
  run-test $TARGET "`cat <<-SRC

#include <stdio.h>
#include <check/dcheck.h>
int main (void) {
  DCHECK(0);
  return 0;
}

SRC`"
  return $?
}

## DCHECK is off
suite
expect "$? == 0"

## DCHECK is on
CFLAGS+="-D DCHECK_IS_ON"
suite
expect "$? > 0"
