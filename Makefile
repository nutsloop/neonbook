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
SNI ?= _default
DEPLOY_DIR ?= ../../public/$(SNI)/book
PUBLIC_ENTRY ?= ../../public/$(SNI)/neonsignal-book.html

OPEN_URL ?= 0.0.0.0:8080

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
	touch $(PUBLIC_ENTRY)
	printf '%s\n' \
	'<!DOCTYPE html>' \
	'<html lang="en">' \
	'<head>' \
	'<meta charset="UTF-8" />' \
	'<meta http-equiv="refresh" content="0; url=/book/index.html" />' \
	'<meta name="viewport" content="width=device-width, initial-scale=1" />' \
	'<title>Neonsignal Book</title>' \
	'<style>' \
	'body {' \
	'margin: 0;' \
	'min-height: 100vh;' \
	'display: grid;' \
	'place-items: center;' \
	'background: #07070b;' \
	'color: #d9e6ff;' \
	'font-family: "Fira Code", "JetBrains Mono", "SF Mono", monospace;' \
	'}' \
	'a {' \
	'color: #6fffe9;' \
	'text-decoration: none;' \
	'}' \
	'</style>' \
	'</head>' \
	'<body>' \
	'<p>Loading documentation… <a href="/book/index.html">Open docs</a></p>' \
	'</body>' \
	'</html>' \
	> "$(PUBLIC_ENTRY)"
	$(PYTHON) -m webbrowser "https://$(OPEN_URL)/book/index.html"
