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

exports.test_render = ->
  world = god(rx_mock(rx), {})

  render_mock = (dict) ->
    contents = god(rx_mock(rx), dict)
    render(contents)

  render_real = (dict) ->
    contents = god(rx, dict)
    render(contents)

  get_label = (tag) -> tag.attr.class[0]
  
  describe 'Render', ->
    it "rx_mock exists", ->
      assert.ok world.T, 'Has HTML Tags'
      assert.ok world.T().div, 'Has HTML div'
      assert.ok world.T().span, 'Has HTML span'
      assert.ok world.T().p, 'Has HTML p'
      assert.ok world.SVG, 'Has SVG Tags'
      assert.ok world.SVG().g, 'Has SVG g'
      assert.ok world.SVG().path, 'Has SVG path'

    it "render_mock", ->
      result = render_mock({})
      assert.ok result.tag, "mock tag"
      assert.ok result.attr, "mock attr"
      assert.ok result.body, "mock body"

    it "render root", ->
      result = render_mock({})
      assert.equal result.tag, 'div', 'root tag'
      assert.equal result.attr.id, 'root', 'root id'
      assert.ok result.body, 'root body'

    it "render rows", ->
      assert.ok make.rows, 'group rows'
      assert.ok row_dict = make.rows('rows', ['alpha', 'beta']), 'create rows'

      assert.ok tags = render_mock(row_dict).body, 'render rows'
      assert.equal get_label(tags), 'rows', 'row label'
      assert.ok row_tags = tags.body, 'extract rows'
      assert.ok row = row_tags[0], "first row"
      assert.equal row.tag, 'div', 'row tag'
      assert.equal get_label(row), 'alpha', 'row label'

    it "render cols", ->
      assert.ok make.columns, 'group cols'
      assert.ok col_dict = make.columns('cols', ['alpha', 'beta']), 'create cols'

      assert.ok tags = render_mock(col_dict).body, 'render cols'
      assert.equal tags.tag, 'div', 'cols tag'
      assert.equal get_label(tags), 'cols', 'col label'
      assert.ok col_tags = tags.body, 'extract cols'
      
      assert.ok col = col_tags[0], "first col"
      assert.equal col.tag, 'span', 'col tag'
      assert.equal get_label(col), 'alpha', 'col label'

    it "render svg", ->
      svg_dict = {paths: ['M0,0'], name: 'ME'}
      body = render_mock(svg_dict).body
      assert.equal body.tag, 'svg', 'svg tag'
      g = body.body[0]
      assert.equal g.tag, 'g', 'g tag'
      children = g.body
      assert.equal children[0].tag, 'path', 'path tag'
      assert.equal children[1].tag, 'text', 'name tag'

    it "render buttons", ->
      dict = make.buttons('button',["a", "b"], my.control)
      buttons = render_mock(dict).body.body
      button = buttons[0] 
      assert.equal button.tag, 'button', 'button span'
      assert.ok style = button.attr.style, 'button style'

      child = button.body[0]
      assert.equal child, 'a', 'button renders just text'

    it "name tag not button", ->
      assert.ok body = render_real(name: 'me'), 'render_real'
      assert.equal body.find('span').length, 1, 'render_real as span'

    it "render non-mock", ->
      svg_dict = {paths: ['M0,0'], name: 'ME', width: 100, height:100}
      assert.ok body  = render_real(svg_dict), "real svg"
      assert.ok group = body.find('g'), 'has group'
      assert.equal group.find('> path').attr('d'), svg_dict.paths[0], 'svg_dict.paths'
      assert.equal group.find('> text').text(), svg_dict.name, 'svg_dict.name'

    it "render selection"

    it "render class attribute", ->
      assert.ok body = render_real(name: 'ME', class: 'testclass'), 'render real class'
      assert.equal body.find('.testclass').length, 1, 'class length'
