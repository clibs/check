CFLAGS+="-I include "
CC=gcc

run-test () {
  local target="$1"
  local src="$2"
  rm -f $TARGET
  if echo "$src" | $CC -o $target $CFLAGS -xc -; then
    if test -f $target; then
      eval "./$target 2>/dev/null" 2>/dev/null
      let local rc=$?
      rm -f ./$target
      return $rc
    fi
  fi
  return 0
}

assert () {
  let local condition=$1
  local message="$2"

  if ! (( $condition )); then
    { echo $message; } >&2
      exit 1
  fi

  return 0
}

expect () {
  local expr=$@
  local op=`expr "'$expr'"`
  if ! (( $expr )); then
    assert 0 "AssertionError: true != \`$expr\`"
    return 1
  fi
  return 0
}
