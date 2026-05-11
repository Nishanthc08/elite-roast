.PHONY: all build test lint sign clean help

all: build

build:
	bash build.sh

test:
	@for t in debian/tests/basic-roast debian/tests/unknown-cmd debian/tests/failure-counter debian/tests/clean-removal; do \
		echo "--- $$(basename $$t) ---"; \
		bash $$t && echo "PASS" || echo "FAIL"; \
	done

lint: build
	lintian elite-roast_1.0_all.deb

sign: build
	bash sign.sh

clean:
	rm -f elite-roast_1.0_all.deb
	rm -rf /tmp/elite-roast_*

help:
	@echo "  make build    - build the .deb package"
	@echo "  make test     - run the test suite"
	@echo "  make lint     - build and run lintian"
	@echo "  make sign     - build and GPG sign the .deb"
	@echo "  make clean    - remove build artifacts"
