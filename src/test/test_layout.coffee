{god} = require '../god'

rx_mock = require './rx_mock'

render = (dict) ->
  world = god(rx_mock(), dict)
  world.call('render')

exports.test_layout = (test, rx) ->
  solo = god(rx, {
    size: 480
    scale: 80
    fill: "green"
    stroke: "black"
    path: "M0,0 L100,100"
  })

  test "rx_mock  exists", (t) ->
    t.ok draw, "draw"
    t.ok solo, "solo"
    t.ok family, "family"
    t.end()
