class Ground < RedisModel
  attr_accessor :language, :code
  
  validates :language, presence: true
end