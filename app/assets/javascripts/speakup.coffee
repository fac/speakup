window.Speakup = {
  Components: {}
}

window.wsUri = (scheme) ->
  scheme + window.document.location.host + "/";

window.createWebsocket = (uri, onData) ->
  ws = new WebSocket(uri)
  ws.onopen = (message) =>
    # do nothing
  ws.onmessage = (message) =>
    data = JSON.parse(message.data)
    onData(data)
  ws
