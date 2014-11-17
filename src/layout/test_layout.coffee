{my} = require '../my'
{game} = require '../game'

{layout} = require '../layout'
{header} = require './header'
{controls} = require './controls'
{grid} = require './grid'
{sprite} = require './sprite'

exports.test_layout = (test, rx) ->
  game_dict = game({name: 'example', level: 1})
  config = layout(game_dict)

  test "config exists", (t) ->
    t.ok game_dict, 'game_dict'
    t.ok config, 'config'
    console.log 'game config', config
    t.end()
  
  test "layout header", (t) ->
    t.ok header, 'header'
    t.end()

  test "layout controls", (t) ->
    t.ok controls, 'controls'
    t.end()

  test "layout grid", (t) ->
    t.ok grid, 'grid'
    t.end()

