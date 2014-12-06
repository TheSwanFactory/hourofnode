# TODO: Run SVG tests with rx instead of rx_mock

{my} = require '../my'
{god} = require '../god'
{rx_mock} = require './rx_mock'
{vector} = require '../god/vector'
{render} = require '../render'
{make} = require '../render/make'

{layout} = require '../layout'
{header} = require '../layout/header'
{grid} = require '../layout/grid'
{controls} = require '../layout/controls'

exports.test_render = (test, rx) ->
  world = god(rx_mock(rx), {})

  render_mock = (dict) ->
    contents = god(rx_mock(rx), dict)
    render(contents)

  render_real = (dict) ->
    contents = god(rx, dict)
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
    svg_dict = {paths: ['M0,0'], name: 'ME'}
    body = render_mock(svg_dict).body
    t.equal body.tag, 'svg', 'svg tag'
    g = body.body[0]
    t.equal g.tag, 'g', 'g tag'
    children = g.body
    t.equal children[0].tag, 'path', 'path tag'
    t.equal children[1].tag, 'text', 'name tag'
    t.end()

  test "render buttons", (t) ->
    dict = make.buttons('button',["a", "b"], my.control)
    buttons = render_mock(dict).body.body
    button = buttons[0] 
    t.equal button.tag, 'button', 'button span'
    t.ok style = button.attr.style, 'button style'

    child = button.body[0]
    t.equal child, 'a', 'button renders just text'
    t.end()

  test "name tag not button", (t) ->
    t.ok body = render_real(name: 'me'), 'render_real'
    t.equal body.find('span').length, 1, 'render_real as span'
    t.end()

  test "render non-mock", (t) ->
    svg_dict = {paths: ['M0,0'], name: 'ME', width: 100, height:100}
    t.ok body  = render_real(svg_dict), "real svg"
    t.ok group = body.find('g'), 'has group'
    t.equal group.find('> path').attr('d'), svg_dict.paths[0], 'svg_dict.paths'
    t.equal group.find('> text').text(), svg_dict.name, 'svg_dict.name'
    t.end()

  test "render selection", (t) ->
    t.end()

  test "render class attribute", (t) ->
    t.ok body = render_real(name: 'ME', class: 'testclass'), 'render real class'
    t.equal body.find('.testclass').length, 1, 'class length'
    t.end()
