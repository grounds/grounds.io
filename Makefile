.PHONY: build push clean fclean run test console

REPOSITORY := $(if $(REPOSITORY),$(REPOSITORY),'grounds')
TAG        := $(if $(TAG),$(TAG),'latest')
RAILS_ENV  := $(if $(RAILS_ENV),$(RAILS_ENV),'development')

# A default secret key base is set as convenience to test production mode,
# but it should be changed in production.
SECRET_KEY_BASE := $(if $(SECRET_KEY_BASE),$(SECRET_KEY_BASE),'729ef9ead52e970ae6c02c30ff1be69409c603036990fb11f5701a48fff0626f6259c58b0ccdd1f8b1e7a81bc59e61240cd0411e74c4a7b6094f371369f97caf')

env    := RAILS_ENV=$(RAILS_ENV)
secret := SECRET_KEY_BASE=$(SECRET_KEY_BASE)

all: run

re: clean all

clean:
	fig kill
	fig rm --force
	rm -f tmp/pids/server.pid

build:
	fig -p groundsio build image

# Update Gemfile.lock according to Gemfile
update: clean
	$(env) fig run web bundle update

# Pull every images required to run
pull:
	hack/pull.sh $(REPOSITORY)

# Push image build to a repository
push: build
	hack/push.sh $(REPOSITORY) $(TAG)

run: build clean
	$(env) $(secret) fig up runner web

fclean:
	rm -f tmp/pids/server.pid

run: build fclean
	$(env) fig up runner web

test: build
	fig run test

# Open rails console
console: build
	touch pry/.pry_history
	$(env) fig run web rails console
