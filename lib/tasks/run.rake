RAILS_ENV  = ENV['RAILS_ENV']  || 'development'
RAILS_PORT = ENV['RAILS_PORT'] || 3000
TEST_OPTS  = ENV['TEST_OPTS']

task :run => :environment do
  if production?
    sh 'bundle exec rake assets:precompile'
  end
  sh <<-EOF
  REDIS_URL=#{redis_url} \
  RUNNER_URL=#{runner_url} \
  bundle exec rails server -b 0.0.0.0 -p #{RAILS_PORT}
  EOF
end

task :test => :environment do
  sh <<-EOF
  RAILS_ENV=test
  RUNNER_URL=#{runner_url} \
  bundle exec rspec --format documentation --color #{TEST_OPTS}
  EOF
end

def production?
  RAILS_ENV == 'production'
end

# Fetch runner url from env (if running natively),
# or look for a runner on the same docker host
def runner_url
  ENV['RUNNER_URL'].presence || docker_url_with(8080)
end

# Fetch redis url from env (if running natively),
# or look for a redis instance linked to this
# container
def redis_url
  url = ENV['REDIS_URL'] || ENV['REDIS_PORT'] || ''
  url.gsub('tcp', 'redis')
     .gsub('http', 'redis')
end

# Parse docker url with a custom port
def docker_url_with(port)
  "http://#{docker_host}:#{port}"
end

def docker_host
  URI.parse(ENV['DOCKER_URL']).host
end
