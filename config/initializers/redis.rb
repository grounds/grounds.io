if ENV['RAILS_ENV'] != 'test'
  redis = Redis.new(url: ENV['REDIS_URL'], password: ENV['REDIS_PASSWORD'])

  $redis = Redis::Namespace.new('grounds', redis: redis)
end
