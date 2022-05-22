SHELL = /bin/bash
.ONESHELL:
.DEFAULT_GOAL: help

help: ## Prints available commands
	@awk 'BEGIN {FS = ":.*##"; printf "Usage: make \033[36m<target>\033[0m\n"} /^[.a-zA-Z_-]+:.*?##/ { printf "  \033[36m%-25s\033[0m %s\n", $$1, $$2 } /^##@/ { printf "\n\033[1m%s\033[0m\n", substr($$0, 5) } ' $(MAKEFILE_LIST)

bundle.install: ## Installs the Ruby gems
	@docker-compose run --rm ruby bundle install

bash: ## Creates a container Bash
	@docker-compose run --rm ruby bash

run.tests: ## Runs Unit tests
	@docker-compose run --rm ruby ruby -Itest test/all.rb

rubocop: ## Runs code linter with auto-correction
	@docker-compose run --rm ruby rubocop -A

ci: ## Runs code linter and unit tests in CI
	bundle lock --add-platform x86_64-linux
	bundle install
	rubocop
	ruby -Itest test/all.rb

sample.hello-app: ## Runs a sample Hello World app
	@docker-compose run \
		--service-ports \
		--rm \
		ruby \
		bash -c "./sample/hello_app/run"

sample.login-app: ## Runs a sample app with Login feature
	@docker-compose run \
		--service-ports \
		--rm \
		ruby \
		bash -c "./sample/login_app/run"
