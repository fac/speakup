Speakup.Components.Room = React.createClass
  getInitialState: ->
    ws = new WebSocket(@props.uri)
    ws.onopen = (message) =>
      # do nothing
    ws.onmessage = (message) =>
      data = JSON.parse(message.data)
      switch data.message
        when "scores"
          scores = data.scores
          score = scores[@props.roomId]
          @setState(avgScore: score)
        else
          console.log("Unrecognised message")
          console.log(data)
    {
      avgScore: this.props.initialAvgScore
      userScore: this.props.initialUserScore
      ws: ws
    }

  componentDidMount: ->
    @renderChart()

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
    return false

  btnClass: (score) ->
    if score?.toString() == @state.userScore?.toString()
      "active btn btn-default"
    else
      "btn btn-default"

  renderChart: ->
    graph = new Rickshaw.Graph({
      element: document.querySelector("#chart"),
      height: 200,
      renderer: 'bar',
      series: [{
        color: 'steelblue',
        data: [
              { x: 0, y: 40 },
              { x: 1, y: 49 },
              { x: 2, y: 38 },
              { x: 3, y: 30 },
              { x: 4, y: 8 },
              { x: 5, y: 9 },
              { x: 6, y: 10 },
              { x: 7, y: 12 },
              { x: 8, y: 9 },
              { x: 9, y: 40 },
              ]}]})
    graph.render()

  btn: (score, comment) ->
    <a href="#" data-value={score} onClick={@onSelect} className={@btnClass(score)}>{"#{score}#{comment}"}</a>

  render: ->
    scoreClass = if @state.avgScore < 1.5
                   "badScore"
                 else
                   ""
    <div>
      <p className="stat">
        <strong>Average score </strong>
        <span className={scoreClass}>{@displayScore(@state.avgScore)}</span>
      </p>
      <div id="chart"></div>
      <div className="btn-group btn-group-justified">
        {@btn(1, " (Worst)")}
        {@btn(2, "")}
        {@btn(3, "")}
        {@btn(4, "")}
        {@btn(5, " (Best)")}
      </div>
    </div>


