# check

Super basic `CHECK()`, `DCHECK()`, and `NOTREACHED()` macro implementations.

## install

```sh
$ clib install check
```

## usage

[As described by the Chromium
authors](https://www.chromium.org/developers/coding-style#TOC-CHECK-DCHECK-and-NOTREACHED-):

> The `CHECK()` macro will cause an immediate crash if its condition is
> not met. `DCHECK()` is like `CHECK()` but is only compiled in when
> `DCHECK_IS_ON` is true (debug builds and some bot configurations, but
> not end-user builds). `NOTREACHED()` is equivalent to `DCHECK(0)`.
> Here are some rules for using these:

> Use `DCHECK()` or `NOTREACHED()` as assertions, e.g. to document pre- and
> post-conditions. A `DCHECK()` means *"this condition must always be true"*,
> not **"this condition is normally true, but perhaps not in exceptional
> cases."** Things like disk corruption or strange network errors are
> examples of exceptional circumstances that nevertheless should not
> result in `DCHECK()` failure.

> A consequence of this is that you should not handle `DCHECK()` failures,
> even if failure would result in a crash. Attempting to handle a `DCHECK()`
> failure is a statement that the `DCHECK()` can fail, which contradicts the
> point of writing the `DCHECK()`. In particular, do not write code like the
> following:

```c
 DCHECK(foo);
if (!foo) ...  // Can't succeed!

// Replace this whole conditional with "DCHECK(bar);" and
// keep going instead.
if (!bar) {
  NOTREACHED();
  return;
}
...
```

> Use `CHECK()` if the consequence of a failed assertion would be a security
> vulnerability, where crashing the browser is preferable. Because this
> takes down the whole browser, sometimes there are better options than
> `CHECK()`. For example, if a renderer sends the browser process a
> malformed IPC, an attacker may control the renderer, but we can simply
> kill the offending renderer instead of crashing the whole browser.
> You can temporarily use `CHECK()` instead of `DCHECK()` when trying to force
> crashes in release builds to sniff out which of your assertions is
> failing. Don't leave these in the codebase forever; remove them or
> change them back once you've solved the problem.
> Don't use these macros in tests, as they crash the test binary and leave
> bots in a bad state. Use the `ASSERT_xx()` and `EXPECT_xx()` family of
> macros, which report failures gracefully and can continue running other
> tests.

### CHECK()

```c
CHECK(user->data);
```

### DCHECK()

```c
CHECK(user->data);
// do something with user dat
DCHECK(user->network_connection);
```

### NOTREACHED()

```c
#ifdef BROKEN_CODE
NOTREACHED();
#endif
```

## license

MIT
