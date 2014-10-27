class Ground < RedisModel
  attr_accessor :language, :code
  
  validates :language, presence: true

  def self.new_or_default(language)
    self.new(language: language || Editor.default_option_code(:language)) 
  end
end
