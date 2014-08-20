# This is a total hack.
class Websocket

  KEEPALIVE_TIME = 15 # seconds

  def initialize(app)
    @app = app
    @clients = []
  end

  def call(env)
    if Faye::WebSocket.websocket?(env)
      puts env.has_key?("rack.input")
      puts env["rack.input"].read
      ws = Faye::WebSocket.new(env, nil, {ping: KEEPALIVE_TIME })
      ws.on :open do |event|
        puts "WS opened connection"
        @clients << ws
        ws.send('{"message": "hello"}')
      end

      ws.on :message do |event|
        puts "got message"
        data = JSON.parse(event.data)
        case data["message"]
        when "get_scores"
          @clients.each do |ws|
            # For now, we just send all data to all clients
            # and let them sort it out.
            ws.send({message: "scores", scores: Room.average_scores}.to_json)
          end
        else
          puts "Unrecognised message"
          puts data
        end
      end

      ws.on :close do |event|
        @clients.delete(ws)
        ws = nil
      end

      # Return async Rack response
      ws.rack_response
    else
      @app.call(env)
    end
  end
end
