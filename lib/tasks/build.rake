PORT = ENV['RAILS_PORT'] || 3000

task :run => :environment do
  if production?
    sh 'bundle exec rake assets:precompile'
  end
  sh "bundle exec rails server -p #{PORT}"
end

task :test => :environment do
  sh 'bundle exec rspec --format documentation --color'
end

def production?
  ENV['RAILS_ENV'] == 'production'
end


