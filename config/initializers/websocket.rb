module WebSocket
  extend self

  def url
    ENV['WEBSOCKET_URL']
  end
end
