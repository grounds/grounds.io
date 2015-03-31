desc 'Run rails with environment properly configured'
task :run do
  if production?
    sh 'bundle exec rake assets:precompile'
  end

  set_runner
  set_redis

  sh 'rails server -b 0.0.0.0 -p 3000'
end

desc 'Run the test suite with environment properly configured'
task :test do
  ENV['RAILS_ENV'] = 'test'

  set_runner

  sh "rspec --format documentation --color #{ENV['TEST_OPTS']}"
end

def production?
  ENV['RAILS_ENV'] == 'production'
end

# Docker Compose unfortunately sets environment variables inherited
# from the host to an empty string if these are missing in the host
# environment. Therefore we need to set this variables to nil if empty.
# Thanks to rails '.presence' returns nil if the variable is nil or empty.

# Fetch runner url from env (if running natively), or look for a runner on
# the same docker host.
def set_runner
  ENV['RUNNER_URL'] = ENV['RUNNER_URL'].presence || docker_url_with(8080)
end

# Fetch redis url from env (if running natively), or look for a redis instance
# linked to this container (docker compose recommends to use links name instead
# of using docker links environment variables).
def set_redis
  ENV['REDIS_URL'] = ENV['REDIS_URL'].presence || 'redis://redis:6379'
  ENV['REDIS_PASSWORD'] = ENV['REDIS_PASSWORD'].presence
end

# Parse docker url with a custom port
def docker_url_with(port)
  "http://#{docker_host}:#{port}"
end

def docker_host
  URI.parse(ENV['DOCKER_URL']).host
end
