.PHONY: all re clean build install update pull push run detach test console

REPOSITORY := $(if $(REPOSITORY),$(REPOSITORY),'grounds')
TAG        := $(if $(TAG),$(TAG),'latest')
RAILS_ENV  := $(if $(RAILS_ENV),$(RAILS_ENV),'development')

# A default secret key base is set as convenience to test production mode,
# but it should be changed in production.
SECRET_KEY_BASE := $(if $(SECRET_KEY_BASE),$(SECRET_KEY_BASE),'729ef9ead52e970ae6c02c30ff1be69409c603036990fb11f5701a48fff0626f6259c58b0ccdd1f8b1e7a81bc59e61240cd0411e74c4a7b6094f371369f97caf')

env       := RAILS_ENV=$(RAILS_ENV) REPOSITORY=$(REPOSITORY)
secret    := SECRET_KEY_BASE=$(SECRET_KEY_BASE)
compose   := docker-compose -p groundsio
run       := $(compose) run web

all: detach

re: build clean all

clean:
	$(compose) kill
	$(compose) rm --force
	rm -f tmp/pids/server.pid

build:
	$(compose) build web

# Install gems in Gemfile.lock
install: clean
	$(env) $(run) bundle install

# Update gems in Gemfile.lock
update: clean
	$(env) $(run) bundle update

# Pull every images required to run
pull:
	scripts/pull.sh $(REPOSITORY)

# Push image build to a repository
push:
	scripts/push.sh $(REPOSITORY) $(TAG)

run: build clean
	$(env) $(secret) $(compose) up

detach:
	$(env) $(secret) $(compose) up -d

test: build clean
	$(env) $(compose) up -d runner
	RAILS_ENV="test" $(run) rake test

# Open rails console
console: build clean
	touch pry/.pry_history
	$(env) $(run) rails console
