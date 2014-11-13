{my} = require '../my'
{god} = require '../god'
{rx_mock} = require './rx_mock'
{vector} = require '../god/vector'

{layout} = require '../layout'
{render} = require '../layout/render'
{header} = require '../layout/header'
{grid} = require '../layout/grid'
{controls} = require '../layout/controls'
{make} = require '../layout/make'

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
    t.ok make.rows, 'group rows'
    t.ok row_dict = make.rows('rows', ['alpha', 'beta']), 'create rows'

    t.ok tags = render_mock(row_dict).body, 'render rows'
    t.equal get_label(tags), 'rows', 'row label'
    t.ok row_tags = tags.body, 'extract rows'
    t.ok row = row_tags[0], "first row"
    t.equal row.tag, 'div', 'row tag'
    t.equal get_label(row), 'alpha', 'row label'
    t.end()

  test "render cols", (t) ->
    t.ok make.columns, 'group cols'
    t.ok col_dict = make.columns('cols', ['alpha', 'beta']), 'create cols'

    t.ok tags = render_mock(col_dict).body, 'render cols'
    t.equal tags.tag, 'div', 'cols tag'
    t.equal get_label(tags), 'cols', 'col label'
    t.ok col_tags = tags.body, 'extract cols'
    
    t.ok col = col_tags[0], "first col"
    t.equal col.tag, 'span', 'col tag'
    t.equal get_label(col), 'alpha', 'col label'
    t.end()

  test "render svg", (t) ->
    svg_dict = {paths: ['M0,0']}
    body = render_mock(svg_dict ).body
    t.equal body.tag, 'svg', 'svg tag'
    t.equal body.body.tag, 'g', 'g tag'
    children = body.body.body
    t.equal children[0].tag, 'path', 'path tag'
    t.skip 'name tag'
    t.end()

  test "render buttons", (t) ->
    dict = make.buttons('button',["a", "b"], my.control)
    buttons = render_mock(dict).body.body
    button = buttons[0] 
    t.equal button.tag, 'span', 'button span'
    t.ok style = button.attr.style, 'button style'
    t.ok style.border, 'button border'
    t.ok style.margin, 'button margin'

    child = button.body[0]
    console.log "buttons child #{child}", child
    t.equal child.tag, 'p', 'name tag'
    t.end()

  test "render selection", (t) ->
    t.end()

  # TODO: Remove these as redundant
  
  test "render header", (t) ->
    t.ok header, 'header'
    body = render_mock(header).body
    t.equal body.tag, 'div', 'body.tag'
    t.equal get_label(body), header._LABEL, 'header label'
    t.end()

  test "render grid", (t) ->
    t.ok grid, 'grid'
    body = render_mock(grid).body
    t.equal body.tag, 'svg', 'body.tag'
    t.equal get_label(body.body), grid._LABEL, 'grid label'
    t.end()

  test "render controls", (t) ->
    t.ok controls, 'controls'
    body = render_mock(controls).body
    t.equal body.tag, 'div', 'body.tag'
    t.equal get_label(body), controls._LABEL, 'controls label'
    
    button = body.body[0] 
    t.equal button.tag, 'span', 'button span'
    t.ok style = button.attr.style, 'button style'
    t.ok style.border, 'button border'
    t.ok style.margin, 'button margin'
    t.end()

