PYTHON ?= python3
SPHINXBUILD ?= $(PYTHON) -m sphinx
SPHINXOPTS ?= -q
SOURCEDIR ?= source
BUILDDIR ?= build
THEME ?= neon-synth
NEONBOOK_THEME ?= $(THEME)
NEONBOOK_VHS ?= on
NEONBOOK_PERF_LOG ?= off
NEONBOOK_PERF_SOUND ?= off
NEONBOOK_PERF_NOTIFY ?= off
DEPLOY_DIR ?= ../neonsignal/public/_default/book

.PHONY: html open open-browser deploy

html:
	NEONBOOK_THEME=$(NEONBOOK_THEME) \
	NEONBOOK_VHS=$(NEONBOOK_VHS) \
	NEONBOOK_PERF_LOG=$(NEONBOOK_PERF_LOG) \
	NEONBOOK_PERF_SOUND=$(NEONBOOK_PERF_SOUND) \
	NEONBOOK_PERF_NOTIFY=$(NEONBOOK_PERF_NOTIFY) \
	$(SPHINXBUILD) $(SPHINXOPTS) -b html $(SOURCEDIR) $(BUILDDIR)/book

open: html
	$(PYTHON) -m webbrowser "file://$(abspath $(BUILDDIR)/html/index.html)"

open-browser: open

deploy: html
	rm -rf $(DEPLOY_DIR)
	mkdir -p $(DEPLOY_DIR)
	cp -r $(BUILDDIR)/book/* $(DEPLOY_DIR)/
	$(PYTHON) -m webbrowser "https://10.0.0.106:8888/book/index.html"
