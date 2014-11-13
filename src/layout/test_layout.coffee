{my} = require '../my'

{game} = require '../game'
{layout} = require '../layout'
{header} = require '../layout/header'
{grid} = require '../layout/grid'
{controls} = require '../layout/controls'

exports.test_layout = (test, rx) ->
  game_dict = game({name: 'example', level: 1})
  config = layout(game_dict)

  test "layout exists", (t) ->
    t.ok layout, 'layout'
    t.end()
  
  test "layout header", (t) ->
    t.ok header, 'header'
    body = render_mock(header).body
    t.equal body.tag, 'div', 'body.tag'
    t.equal get_label(body), header._LABEL, 'header label'
    t.end()

  test "layout grid", (t) ->
    t.ok grid, 'grid'
    body = render_mock(grid).body
    t.equal body.tag, 'svg', 'body.tag'
    t.equal get_label(body.body), grid._LABEL, 'grid label'
    t.end()

  test "layout controls", (t) ->
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

