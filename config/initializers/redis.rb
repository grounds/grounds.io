redis = Redis.new(url: ENV['REDIS_URL'])

$redis = Redis::Namespace.new('grounds', redis: redis)
