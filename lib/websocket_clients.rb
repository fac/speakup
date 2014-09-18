require 'singleton'

# Total hack, won't work unless there is only one server process
class WebsocketClients
  include Singleton

  def initialize
    @clients = []
  end

  def count
    @clients.count
  end

  def add(client)
    @clients << client
    self
  end

  def remove(client)
    @clients.delete(client)
    self
  end

  def push(message, data)
    @clients.dup.each do |ws|
      # For now, we just send all data to all clients
      # and let them sort it out.
      ws.send({message: message, roomData: data}.to_json)
    end
    self
  end

end
