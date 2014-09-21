REPOSITORY = ENV['REPOSITORY'] || 'grounds'
DOCKER_URL = ENV['DOCKER_URL'] || 'http://127.0.0.1:2375'
RAILS_PORT = ENV['RAILS_PORT'] || 3000
EXEC_PORT  = ENV['EXEC_PORT']  || 8080

IMAGE = "#{REPOSITORY}/grounds.io"

redis = 'grounds-redis'
exec  = 'grounds-exec-latest'

task :build => :environment do
  sh "docker build -t #{IMAGE} ."
end

task :test => [:build] do
  sh "docker run -ti #{IMAGE} bundle exec rspec"
end

task :run => [:build, 'detach:redis', 'detach:exec'] do
sh <<-EOF
docker run \
-e WEBSOCKET_URL=#{DOCKER_URL.gsub(/:\d{4}/, ":#{EXEC_PORT}")} \
-p #{RAILS_PORT}:#{RAILS_PORT} \
--link #{redis}:redis \
-ti #{IMAGE} \
bundle exec rails server \
-p #{RAILS_PORT}
EOF

Rake::Task['clean:redis'].execute
Rake::Task['clean:exec'].execute
end

namespace :detach do
  task :redis => ['clean:redis'] do
  sh <<-EOF
  docker run -d \
  --name #{redis} \
  dockerfiles/redis
  EOF
  end

  task :exec => ['clean:exec'] do
  sh <<-EOF
  docker run \
  --name #{exec} \
  -p #{EXEC_PORT}:#{EXEC_PORT} \
  -d #{REPOSITORY}/grounds-exec \
  server \
  -e #{DOCKER_URL} \
  -p #{EXEC_PORT} \
  -r #{REPOSITORY}
  EOF
  end
end

namespace :clean do
  task :redis => :environment do
    if container_exist?(redis)
      sh "docker rm -f #{redis}"
    end
  end

  task :exec => :environment do
    if container_exist?(exec)
      sh "docker rm -f #{exec}"
    end
  end
end

def container_exist?(name)
  `docker inspect --format={{.Created}} #{name} 2>/dev/null`.present?
end
