.PHONY: all re clean build shell pull push run detach test runner

REPOSITORY := $(if $(REPOSITORY),$(REPOSITORY),'grounds')
TAG        := $(if $(TAG),$(TAG),'latest')
RAILS_ENV  := $(if $(RAILS_ENV),$(RAILS_ENV),'development')

# A default secret key base is set as convenience to test production mode,
# but it should be changed in production.
SECRET_KEY_BASE := $(if $(SECRET_KEY_BASE),$(SECRET_KEY_BASE),'729ef9ead52e970ae6c02c30ff1be69409c603036990fb11f5701a48fff0626f6259c58b0ccdd1f8b1e7a81bc59e61240cd0411e74c4a7b6094f371369f97caf')

env       := RAILS_ENV=$(RAILS_ENV) REPOSITORY=$(REPOSITORY)
secret    := SECRET_KEY_BASE=$(SECRET_KEY_BASE)
compose   := docker-compose -p groundsio
run       := $(compose) run --service-ports web

all: detach

re: build clean all

clean:
	$(compose) kill
	$(compose) rm --force
	rm -f tmp/pids/server.pid

build:
	$(compose) build web

# Pull every images required to run
pull:
	scripts/pull.sh $(REPOSITORY)

# Push image build to a repository
push:
	scripts/push.sh $(REPOSITORY) $(TAG)

run: build clean runner
	$(env) $(secret) $(run) rake run

detach:
	$(env) $(secret) $(compose) up -d

test: build clean runner
	$(env) $(run) rake test

# Open a shell with everything set up
shell: build clean runner
	touch pry/.pry_history
	$(env) $(run) /bin/bash

runner:
	$(env) $(compose) up -d runner
