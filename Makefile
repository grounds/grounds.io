.PHONY: build push clean fclean run test shell console

REPOSITORY := $(if $(REPOSITORY),$(REPOSITORY),'grounds')
TAG        := $(if $(TAG),$(TAG),'latest')
RAILS_ENV  := $(if $(RAILS_ENV),$(RAILS_ENV),'development')

SECRET_KEY_BASE := $(if $(SECRET_KEY_BASE),$(SECRET_KEY_BASE),'729ef9ead52e970ae6c02c30ff1be69409c603036990fb11f5701a48fff0626f6259c58b0ccdd1f8b1e7a81bc59e61240cd0411e74c4a7b6094f371369f97caf')

env := RAILS_ENV=$(RAILS_ENV) SECRET_KEY_BASE=$(SECRET_KEY_BASE)

build:
	fig -p groundsio build image

pull:
	hack/pull.sh $(REPOSITORY)

push:
	hack/push.sh $(REPOSITORY) $(TAG)

clean:
	fig kill
	fig rm --force

fclean:
	rm -f tmp/pids/server.pid

run: build fclean
	$(env) fig up runner web

test: build
	RAILS_ENV=test fig run web rake db:create db:migrate test

shell: build
	$(env) fig run web /bin/bash

console: build
	$(env) fig run web rails console
