Speakup.Components.Chart = React.createClass
  getInitialState: ->
    {graph: null}

  componentDidMount: ->
    series = new Rickshaw.Series.FixedDuration([{name: 'avgScore', color: 'steelBlue'}],
                                               undefined,
                                               {
                                                 timeInterval: 250,
                                                 maxDataPoints: 10,
                                                 timeBase: new Date().getTime() / 1000
                                                })
    graph = new Rickshaw.Graph(
             min: 0,
             max: 5
             element: document.getElementById("chart"),
             height: 200,
             renderer: 'bar',
             series: series
             )

    @state.graph?.series?.addData({avgScore: @props.avgScore})
    graph.render()
    @setState(graph: graph)
    @forceUpdate()

  componentDidUpdate: ->
    if @state.graph
      @state.graph?.series?.addData({avgScore: @props.avgScore})
      @state.graph?.render()

  shouldComponentUpdate: (nextProps, nextState) ->
    @props.avgScore != nextProps.avgScore

  render: ->
   <div id="chart_container">
     <div id="y_axis"/>
     <div id="chart"/>
   </div>
