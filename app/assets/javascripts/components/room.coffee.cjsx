Speakup.Components.Room = React.createClass
  getInitialState: ->
    {
      avgScore: this.props.initialAvgScore
      userScore: this.props.initialUserScore
      ws: new WebSocket(@props.uri)
    }

  componentDidMount: ->
    @state.ws.onopen = (message) =>
      @getScores()
    @state.ws.onmessage = (message) =>
      data = JSON.parse(message.data)
      switch data.message
        when "scores"
          scores = data.scores
          @setState(avgScore: scores[@props.roomId])
        else
          console.log("Unrecognised message")
          console.log(data)

  getScores: ->
    @state.ws.send(JSON.stringify({message: "get_scores"}));

  displayScore: (score) ->
    if score
      sprintf("%.2f", score)
    else
      "none"

  postRating: (score) ->
    $.ajax {
      url: '/ratings',
      type: 'POST',
      data: {
        authenticity_token: AUTHENTICITY_TOKEN,
        rating: {
          room_id: @props.roomId
          score: score
        }
      },
      dataType: 'json' }

  onSelect: (event) ->
    value = event.target.dataset.value
    @setState(userScore: value)
    @postRating(value).then(@getScores)

  btnClass: (score) ->
    if score?.toString() == @state.userScore?.toString()
      "active btn btn-default"
    else
      "btn btn-default"

  btn: (score, comment) ->
    <a href="#" data-value={score} onClick={@onSelect} className={@btnClass(score)}>{"#{score}#{comment}"}</a>

  render: ->
    <div>
      <p><strong>Average score</strong> {@displayScore(@state.avgScore)}</p>
      <div className="btn-group btn-group-justified">
        {@btn(1, " (Worst)")}
        {@btn(2, "")}
        {@btn(3, "")}
        {@btn(4, "")}
        {@btn(5, " (Best)")}
      </div>
    </div>
