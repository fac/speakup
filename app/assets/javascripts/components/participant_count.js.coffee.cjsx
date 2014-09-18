Speakup.Components.ParticipantCount = React.createClass

  componentWillUnmount: ->
    alert('unmounting')
    @state.ws.close()

  getInitialState: ->
    ws = createWebsocket @props.uri, (data) =>
      switch data.message
        when "room_data"
          roomData = data.roomData
          @setState(participants: roomData[@props.roomId].participants)
        else
          console.log("Unrecognised message")
          console.log(data)
    {
      participants: @props.initialParticipants
      ws: ws
    }

  render: ->
    <p className="stat">
      <strong>Participants</strong> {@state.participants}
    </p>