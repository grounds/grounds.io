require 'digest/sha1'

class RedisModel
  include ActiveModel::Model

  @@storage = $redis

  attr_reader :id

  def initialize(attributes = {}, id = nil)
    super(attributes)

    @id = id
  end

  def persisted?
    @@storage.exists(@id)
  end
  
  def save
    return false unless valid?

    @id = generate_id
    attributes.each { |k, v| @@storage.hset(@id, k, v) }
    @@storage.persist(@id)
    persisted?
  end

  def destroy
    @@storage.del(@id)
  end

  def attributes
    instance_values.slice!('id', 'validation_context', 'errors')
  end
  
  def self.find(id)
    attributes = @@storage.hgetall(id)

    raise ActiveRecord::RecordNotFound if attributes.empty?

    new(attributes, id)
  end

  private

  def generate_id
    Digest::SHA256.hexdigest(attributes.to_s)
  end
end