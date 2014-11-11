{god} = require '../god'
{layout} = require '../layout'
{render} = require '../layout/render'

{rx_mock}= require './rx_mock'


svg_dict = {
  size: 480
  scale: 80
  fill: "green"
  stroke: "black"
  path: "M0,0 L100,100"
}

exports.test_render = (test, rx) ->

  render_dict = (dict) ->
    world = god(rx_mock(rx), dict)
    render(world)

  test "rx_mock exists", (t) ->
    world = god(rx_mock(rx), {})
    t.ok world.T, 'Has HTML Tags'
    t.ok world.T().div, 'Has HTML div'
    t.ok world.SVG, 'Has SVG Tags'
    t.ok world.SVG().path, 'Has SVG path'
    t.end()

  test "render_dict", (t) ->
    result = render_dict({})
    console.log result
    t.equal result.tag, "div", "mock div"
    t.end()

  test "render root", (t) ->
    t.end()

  test "render world", (t) ->
    t.end()

  test "render children", (t) ->
    t.end()

  test "render html", (t) ->
    # rows
    # columns
    # buttons
    t.end()

  test "render svg", (t) ->
    t.end()

  test "render name", (t) ->
    t.end()
