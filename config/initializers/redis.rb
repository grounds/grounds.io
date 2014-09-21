redis_port = (ENV['REDIS_PORT'] || '').gsub('tcp', 'redis')

redis_url = redis_port.present? ? redis_port : ENV['REDIS_URL']

$redis = Redis::Namespace.new('grounds', redis: Redis.new(url: redis_url))
