# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/


class Room
  constructor: (room_id, ws_scheme) ->
    @room_id = room_id
    @uri = ws_scheme + window.document.location.host + "/";

  start: ->
    console.log("starting")
    @ws = new WebSocket(@uri);
    @ws.onmessage = (message) =>
      data = JSON.parse(message.data)
      console.log(data);
      switch data.message
        when "hello"
          console.log("hello");
          @ws.send(JSON.stringify({message: "get_scores"}));
        when "scores"
          scores = data.scores
          $('#score').html(scores[@room_id])
        else
          console.log("Unrecognised message")
          console.log(data)

window.Room = Room;