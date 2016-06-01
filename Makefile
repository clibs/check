PROJECT_NAME ?= check

## Install headers
.PHONY: install
install:
	$(CP) -rf include/$(PROJECT_NAME) $(PREFIX)/include/$(PROJECT_NAME)

## Uninstall headers
.PHONY: uninstall
uninstall:
	$(RM) -f $(PREFIX)/include/$(PROJECT_NAME)

## Tests
.PHONY: test
test: test/check
test: test/dcheck
test: test/notreached
test/check test/dcheck test/notreached:
	@exec $@.sh
	@echo "exec: $@"
	@echo "  ok: $@"

