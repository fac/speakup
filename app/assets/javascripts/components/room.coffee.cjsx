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
    @setState(userScore: event.target.value)
    @postRating(event.target.value).then(@getScores)

  render: ->
    <div>
      <p>Average score: {@displayScore(@state.avgScore)}</p>
      <form onChange={@onSelect}>
        <label htmlFor="rating_score">Rating </label>
        <select value={@state.userScore} id="rating_score">
          <option value="1">1</option>
          <option value="2">2</option>
          <option value="3">3</option>
          <option value="4">4</option>
          <option value="5">5</option>
        </select>
      </form>
    </div>
