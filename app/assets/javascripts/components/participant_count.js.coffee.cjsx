Speakup.Components.ParticipantCount = React.createClass

  getInitialState: ->
    ws = createWebsocket @props.uri, (data) =>
      switch data.message
        when "room_data"
          roomData = data.roomData
          console.log("new participant data #{roomData[@props.roomId].participants}")
          @setState(participants: roomData[@props.roomId].participants)
        else
          console.log("Unrecognised message")
          console.log(data)
    {
      participants: @props.initialParticipants
      ws: ws
    }

  getRoomData: ->
    @state.ws.send(JSON.stringify({message: "room_data"}));

  componentDidMount: ->
    $('#participants-panel form').submit (event) =>
      console.log('submitting...')
      @getRoomData()

  render: ->
    <p className="stat">
      <strong>Participants</strong> {@state.participants}
    </p>