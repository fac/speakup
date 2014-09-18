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
        # do nothing
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
