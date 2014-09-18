require Rails.root+'lib/websocket_clients'
# This is a total hack.
class Websocket

  KEEPALIVE_TIME = 15 # seconds

  def initialize(app)
    @app = app
    @clients = WebsocketClients.instance
    # @clients = []
  end

  def call(env)
    if Faye::WebSocket.websocket?(env)
      ws = Faye::WebSocket.new(env, nil, {ping: KEEPALIVE_TIME })
      puts "-------"*10
      puts ws.object_id
      puts "-------"*10
      ws.on :open do |event|
        @clients = WebsocketClients.instance.add(ws)
      end

      ws.on :message do |event|
        data = JSON.parse(event.data)
        puts "-------"*10
        puts data
        case data["message"]
        when "room_data"
          WebsocketClients.instance.push('room_data', Room.summary)
          # @clients.each do |ws|
          #   # For now, we just send all data to all clients
          #   # and let them sort it out.
          #   ws.send({message: "room_data", roomData: Room.summary}.to_json)
          # end
        else
          puts "Unrecognised message"
          puts data
        end
      end

      ws.on :close do |event|
        @clients.remove(ws)
        ws = nil
      end

      # Return async Rack response
      ws.rack_response
    else
      @app.call(env)
    end
  end
end
