.PHONY: build push clean fclean run test console

REPOSITORY := $(if $(REPOSITORY),$(REPOSITORY),'grounds')
TAG 	   := $(if $(TAG),$(TAG),'latest')
RAILS_ENV  := $(if $(RAILS_ENV),$(RAILS_ENV),'development')

env := RAILS_ENV=$(RAILS_ENV)

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
	$(env) fig up groundsexec web

test: build
	fig run test

console: build
	$(env) fig run web rails console

