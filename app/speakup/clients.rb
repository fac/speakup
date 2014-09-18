class Clients

  def self.push_room_data
    puts "????"*100
    puts WebsocketClients.instance.count
    puts "????"*100
    WebsocketClients.instance.push('room_data', Room.summary)
  end

end
