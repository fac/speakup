Speakup.Components.ParticipantCount = React.createClass

  getInitialState: ->
    { participants: @props.initialParticipants }

  render: ->
    <p class="stat">
      <strong>Participants</strong> {@state.participants}
    </p>