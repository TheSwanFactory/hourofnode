{god} = require '../god'
{layout} = require '../layout'
{render} = require '../layout/render'

{rx_mock}= require './rx_mock'

render_dict = (dict) ->
  world = god(rx_mock(), dict)
  render(world)

svg_dict = {
  size: 480
  scale: 80
  fill: "green"
  stroke: "black"
  path: "M0,0 L100,100"
}

exports.test_layout = (test, rx) ->

  test "rx_mock exists", (t) ->
    result = render_dict({})
    t.end()
