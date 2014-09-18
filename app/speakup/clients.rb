class Clients

  def self.push_room_data
    WebsocketClients.instance.push('room_data', Room.summary)
  end

end
