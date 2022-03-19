.DEFAULT_GOAL := help
PROJ_DIR := $(shell pwd)
SHELL = /bin/bash

# adjust this if the api is incremented

##@ General

help: ## List the make targets supported
	@echo "Here are the make targets for $(shell basename ${PROJ_DIR})."
	@awk 'BEGIN {FS = ":.*##"; printf "\nUsage:\n  make \033[36m<target>\033[0m\n"} /^[a-zA-Z_0-9-]+:.*?##/ { printf "  \033[36m%-15s\033[0m %s\n", $$1, $$2 } /^##@/ { printf "\n\033[1m%s\033[0m\n", substr($$0, 5) } ' $(MAKEFILE_LIST)

##@ Install - targets to install supporting software

install:  install-plantuml install-yamllint ## install all dependances needed to develop

# TODO: will have to find a way to support mac, WSL2 (debian) and windows.
install-plantuml: ## Url to install plantuml
	@echo "see https://plantuml.com/download to install planatuml on your OS"

install-yamllint: ## Url to install yamllint
	@echo " see https://www.mankier.com/1/yamllint#:~:text=sudo%20apt-get%20install%20yamllint%20On%20Mac%20OS%2010.11%2B%3A,pkg%20install%20py36-yamllint%20On%20OpenBSD%3A%20doas%20pkg_add%20py3-yamllint"

##@ Quality Assurance

qa: qa-yamllint ## the tasks to make sure the repo meet Quality Assurance Standards

qa-test-schema:  ## run Postive and Negative schema validation test cases.
	@echo "TODO:  need to complete schema test data and install for schema validator"

qa-yamllint: ## lint all yaml file in repo
	@yamllint .

.PHONY: help install install-plantuml qa qa-test-schema qa-yamllint