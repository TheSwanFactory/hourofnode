{god} = require '../god'
{rx_mock} = require './rx_mock'

{layout} = require '../layout'
{render} = require '../layout/render'
{header} = require '../layout/header'
{rows,cols} = require '../layout/group'

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

  get_label = (tag) -> tag.attr.class[0]
    
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

  test "render rows", (t) ->
    t.ok rows, 'group rows'
    t.ok row_dict = rows('rows', ['alpha', 'beta']), 'create rows'
    t.ok row_tags = render_mock(row_dict).body.body, 'render rows'
    t.ok tags = render_mock(row_dict).body, 'render rows'
    t.equal get_label(tags), 'rows', 'row label'
    t.ok row_tags = tags.body, 'extract rows'
    t.ok row = row_tags[0], "first row"
    t.equal row.tag, 'div', 'row tag'
    t.equal get_label(row), 'alpha', 'row label'
    t.end()

  test "render cols", (t) ->
    t.ok cols, 'group cols'
    t.ok col_dict = cols('cols', ['alpha', 'beta']), 'create cols'
    t.ok col_tags = render_mock(col_dict).body.body, 'render cols'
    t.ok tags = render_mock(col_dict).body, 'render cols'
    t.equal get_label(tags), 'cols', 'col label'
    t.ok col_tags = tags.body, 'extract cols'
    t.ok col = col_tags[0], "first col"
    t.equal col.tag, 'span', 'col tag'
    t.equal get_label(col), 'alpha', 'col label'
    t.end()

  test "render header", (t) ->
    t.ok header, 'header'
    body = render_mock(header).body
    t.equal body.tag, 'div', 'body.tag'
    t.equal get_label(body), header._LABEL, 'header label'
    t.end()

  test "render buttons", (t) ->
    t.end()

  test "render svg", (t) ->
    t.end()

  test "render name", (t) ->
    t.end()
