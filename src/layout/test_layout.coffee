{my} = require '../my'
{game} = require '../game'
{god} = require '../god'

{layout} = require '../layout'
{header} = require './header'
{controls} = require './controls'
{grid} = require './grid'
{sprite} = require './sprite'

exports.test_layout = (test, rx) ->
  game_dict = game({name: 'example', level: 1})
  config = layout(game_dict)

  test "layout config", (t) ->
    t.ok game_dict, 'game_dict'
    t.ok header, 'header'
    t.ok controls, 'controls'
    t.ok config, 'config'
    t.ok grid, 'grid'
    console.log 'game config', config
    t.end()
  
  test "layout sprites in world", (t) ->
    t.ok world = god(rx, config), 'world'
    t.ok shapes = world.get('shapes'), 'shapes'
    t.ok levels = world.get('levels'), 'levels'
    t.ok world.is_array(levels), 'levels  rx_array'
    t.ok level = levels.at(0), 'level'
    t.end()

