.PHONY: build push clean fclean run test console

REPOSITORY := $(if $(REPOSITORY),$(REPOSITORY),'grounds')
TAG 	   := $(if $(TAG),$(TAG),'latest')
RAILS_ENV  := $(if $(RAILS_ENV),$(RAILS_ENV),'development')

fig := RAILS_ENV=$(RAILS_ENV) fig

build:
	fig -p groundsio build image

pull:
	hack/pull.sh $(REPOSITORY)

push:
	hack/push.sh $(REPOSITORY) $(TAG)

clean:
	fig kill

fclean:
	rm -f tmp/pids/server.pid

run: build fclean
	$(fig) up groundsexec web

test: build
	fig run test

console: build
	$(fig) run web rails console

