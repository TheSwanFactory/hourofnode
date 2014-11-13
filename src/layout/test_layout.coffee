{my} = require '../my'

{game} = require '../game'
{layout} = require '../layout'
{header} = require '../layout/header'
{grid} = require '../layout/grid'
{controls} = require '../layout/controls'

exports.test_layout = (test, rx) ->
  game_dict = game({name: 'example', level: 1})
  config = layout(game_dict)

  test "config exists", (t) ->
    t.ok game_dict, 'game_dict'
    t.ok config, 'config'
    console.log config
    t.end()
  
  test "layout header", (t) ->
    t.ok header, 'header'
    t.end()

  test "layout grid", (t) ->
    t.ok grid, 'grid'
    t.end()

  test "layout controls", (t) ->
    t.ok controls, 'controls'
    t.end()
