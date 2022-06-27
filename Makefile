.DEFAULT_GOAL := help
PROJ_DIR := $(shell pwd)
SHELL = /bin/bash
MEGA_LINTER_IMAGE ?= megalinter/megalinter-documentation:v5

# adjust this if the api is incremented

##@ General

help: ## List the make targets supported
	@echo "Here are the make targets for $(shell basename ${PROJ_DIR})."
	@awk 'BEGIN {FS = ":.*##"; printf "\nUsage:\n  make \033[36m<target>\033[0m\n"} /^[a-zA-Z_0-9-]+:.*?##/ { printf "  \033[36m%-15s\033[0m %s\n", $$1, $$2 } /^##@/ { printf "\n\033[1m%s\033[0m\n", substr($$0, 5) } ' $(MAKEFILE_LIST)

##@ Install - targets to install supporting software

install:  install-plantuml  ## install all dependencies needed to develop

# TODO: will have to find a way to support mac, WSL2 (debian) and windows.
install-plantuml: ## Url to install plantuml
	@echo "see https://plantuml.com/download to install plantuml on your OS"

##@ Quality Assurance - Quality Assurance targets to format, lint and test this repository

qa: lint  ## Run all QA targets on repository

.PHONY: help install install-plantuml qa

COMMON_DIR ?= common-tools
   -include $(COMMON_DIR)/mk/megalinter.mk
