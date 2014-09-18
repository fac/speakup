Speakup.Components.ParticipantCount = React.createClass

  getInitialState: ->
    # TODO - dudupe with other components
    # ws = new WebSocket(@props.uri)
    # ws.onopen = (message) =>
    #   # do nothing
    # ws.onmessage = (message) =>
    #   data = JSON.parse(message.data)
    #   switch data.message
    #     when "scores"
    #       scores = data.scores
    #       score = scores[@props.roomId]
    #       console.log("setting avgscore")
    #       @setState(avgScore: score)
    #     else
    #       console.log("Unrecognised message")
    #       console.log(data)
    { participants: @props.initialParticipants }

  render: ->
    <p className="stat">
      <strong>Participants</strong> {@state.participants}
    </p>