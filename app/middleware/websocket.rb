require 'thread'

class Websocket

  REFRESH_PERIOD = 3 # seconds
  KEEPALIVE_TIME = 15 # seconds

  def initialize(app)
    @app = app
  end

  def call(env)
    if Faye::WebSocket.websocket?(env)
      ws = Faye::WebSocket.new(env, nil, {ping: KEEPALIVE_TIME })
      ws.on :open do |event|
        timer = EM.add_periodic_timer(REFRESH_PERIOD) do
          begin
            # For now, we just send all data to all clients
            # and let them sort it out.
            ws.send(Room.average_scores.to_json) if ws
          rescue StandardError => e
            EM.cancel_timer(timer)
            raise e
          end
        end
      end

      ws.on :message do |event|
      end

      ws.on :close do |event|
        # @clients.delete(ws)
        ws = nil
      end

      # Return async Rack response
      ws.rack_response
    else
      @app.call(env)
    end
  end
end
