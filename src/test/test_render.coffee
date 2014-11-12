{god} = require '../god'
{rx_mock} = require './rx_mock'

{layout} = require '../layout'
{render} = require '../layout/render'
{header} = require '../layout/header'

svg_dict = {
  size: 480
  scale: 80
  fill: "green"
  stroke: "black"
  path: "M0,0 L100,100"
}

exports.test_render = (test, rx) ->
  world = god(rx_mock(rx), {})

  render_mock = (dict) ->
    contents = god(rx_mock(rx), dict)
    render(contents)

  test "rx_mock exists", (t) ->
    t.ok world.T, 'Has HTML Tags'
    t.ok world.T().div, 'Has HTML div'
    t.ok world.T().span, 'Has HTML span'
    t.ok world.T().p, 'Has HTML p'
    t.ok world.SVG, 'Has SVG Tags'
    t.ok world.SVG().g, 'Has SVG g'
    t.ok world.SVG().path, 'Has SVG path'
    t.end()

  test "render_mock", (t) ->
    result = render_mock({})
    t.ok result.tag, "mock tag"
    t.ok result.attr, "mock attr"
    t.ok result.body, "mock body"
    t.end()

  test "render root", (t) ->
    result = render_mock({})
    t.equal result.tag, 'div', 'root tag'
    t.equal result.attr.id, 'root', 'root id'
    t.ok result.body, 'root body'
    t.end()

  test "render header", (t) ->
    t.ok header, 'header'
    body = render_mock(header).body
    t.equal body.tag, 'div', 'body.tag'
    t.equal body.attr.class[0], header._LABEL, 'header label'
      
    t.ok body.body, "header rows"
    t.ok row = body.body[0], "first row"
    t.equal row.tag, 'div', 'row tag'
    t.equal row.attr.class[0], 'game', 'row label'

    t.ok cols = body.body[3], 'last row'
    t.ok col = cols.body[0], 'first col'
    t.equal col.tag, 'span', 'col tag'
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
