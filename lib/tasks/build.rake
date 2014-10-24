RAILS_ENV  = ENV['RAILS_ENV']  || 'development'
RAILS_PORT = ENV['RAILS_PORT'] || 3000
TEST_OPTS  = ENV['TEST_OPTS']


task :run => :environment do
  if production?
    sh 'bundle exec rake assets:precompile'
  end
  sh <<-EOF
  REDIS_URL=#{redis_url} \
  WEBSOCKET_URL=#{grounds_exec_url} \
  bundle exec rails server -p #{RAILS_PORT}
  EOF
end

task :test => :environment do
  sh "bundle exec rspec --format documentation --color #{TEST_OPTS}"
end

def production?
  RAILS_ENV == 'production'
end

def grounds_exec_url
  return ENV['WEBSOCKET_URL'] if ENV['WEBSOCKET_URL'].present?

  if ENV['DOCKER_URL'].present?
    uri = URI.parse(ENV['DOCKER_URL'])
    url = "#{uri.scheme.gsub('https', 'http')}://#{uri.host}:8080"
  end
  url || ''
end

def redis_url
  return ENV['REDIS_URL'] if ENV['REDIS_URL'].present?

  (ENV['REDIS_PORT'] || '').gsub('tcp', 'redis')
end

