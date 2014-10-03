Speakup.Components.Room = React.createClass
  getInitialState: ->
    ws = new WebSocket(@props.uri)
    ws.onopen = (message) =>
      # do nothing
    ws.onmessage = (message) =>
      data = JSON.parse(message.data)
      switch data.message
        when "room_data"
          roomData = data.roomData
          score = roomData[@props.roomId].avgScore
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
    $("button[data-toggle=popover]").popover();
    $(document).keypress (event) =>
      if (49 <= event.which && event.which <= 53)
        @updateScore(event.which - 48)

  updateScore: (score) ->
    @setState(userScore: score)
    @postRating(score)

  componentWillUnmount: ->
    @state.ws.close()

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
    event.preventDefault()
    value = event.target.dataset.value
    @updateScore(value)

  btnClass: (score) ->
    if score?.toString() == @state.userScore?.toString()
      "active btn btn-default"
    else
      "btn btn-default"

  btn: (score, comment) ->
    <a href="#" data-value={score} onClick={@onSelect} className={@btnClass(score)}>{"#{score}#{comment}"}</a>

  tooQuiet: ->
    (@state.avgScore && @state.avgScore < 3)

  render: ->
    scoreButtons = if @props.canSubmitScore
                     <div className="btn-group btn-group-justified">
                       {@btn(1, "")}
                       {@btn(2, "")}
                       {@btn(3, "")}
                       {@btn(4, "")}
                       {@btn(5, "")}
                     </div>

    <div>
      <div className="col-lg-3">
        <div className={React.addons.classSet("panel": true, verdict:true, louder: @tooQuiet())}>
          { if @tooQuiet()
              "LOUDER"
            else
              "OKAY"
          }
        </div>
      </div>
      <div className="col-lg-6">
        <div className="panel panel-primary">
          <div className="panel-heading clearfix">
            <h3 className="panel-title pull-left">Volume score</h3>
            <button type="button"
              className="btn btn-sm btn-info pull-right"
              data-toggle="popover"
              data-placement="bottom"
              data-html="true"
              data-container="body"
              data-content="<p>Throughout the meeting, each participant in a room can vote on the meeting volume (5 is the best).</p><p>The average of each participant's <em>most recent</em> vote is displayed.</p><p>Tip: Use the number keys 1-5 to quickly enter your score.</p>">
                ?
            </button>
          </div>
          <div className="panel-body">
            <p className="stat">
              <strong>Average score </strong>
              {@displayScore(@state.avgScore)}
            </p>
            <Speakup.Components.Chart avgScore={@state.avgScore}/>
            {scoreButtons}
          </div>
        </div>
      </div>
    </div>

