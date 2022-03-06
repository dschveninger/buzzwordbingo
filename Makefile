.DEFAULT_GOAL := help
PROJ_DIR := $(shell pwd)
SHELL = /bin/bash

# adjust this if the api is incremented

##@ General

help: ## List the make targets supported
	@echo "Here are the make targets for $(shell basename ${PROJ_DIR})."
	@awk 'BEGIN {FS = ":.*##"; printf "\nUsage:\n  make \033[36m<target>\033[0m\n"} /^[a-zA-Z_0-9-]+:.*?##/ { printf "  \033[36m%-15s\033[0m %s\n", $$1, $$2 } /^##@/ { printf "\n\033[1m%s\033[0m\n", substr($$0, 5) } ' $(MAKEFILE_LIST)

##@ Install - targets to install supporting software

install:  install-plantuml ## install all dependances needed to develop
	@echo "Coming soon..."

install-plantuml:
	@echo "see https://plantuml.com/download to install planatuml on your OS"

##@ Quality Assurance

qa: ## the tasks to make sure the repo meet Quality Assurance Standards
	@echo "coming soon..."

.PHONY: help install install-plantuml qa