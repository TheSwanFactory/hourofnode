{my} = require '../my'
{game} = require '../game'
{god} = require '../god'

{layout} = require '../layout'
{header} = require './header'
{controls} = require './controls'
{grid} = require './grid'
{sprites} = require './sprites'

exports.test_layout = (test, rx) ->
  game_dict = game({name: 'example', level: 1})
  config = layout(game_dict)
  world = god(rx, config)

  test "layout config", (t) ->
    t.ok game_dict, 'game_dict'
    t.ok header, 'header'
    t.ok controls, 'controls'
    t.ok config, 'config'
    t.ok grid, 'grid'
    t.ok world, 'world'
    console.log 'game config', config, world
    t.end()
  
  test "layout properties", (t) ->
    t.ok shapes = world.get('shapes'), 'shapes'
    t.ok levels = world.get('levels'), 'levels'
    t.ok world.is_array(levels), 'levels rx_array'

    t.ok level = world._child_array()[0], 'active level'
    t.ok sprites = level.get('sprites'), 'sprites'
    t.ok world.is_array(sprites), 'sprites rx_array'
    t.ok sprite_dict = sprites.at(0), 'sprite'
    t.end()

  test "layout children", (t) ->
    t.ok level = world.find_child(), 'active level'
    t.ok grid = level.find_child('grid'), 'grid'
    t.ok all_sprites = grid.find_child('sprites'), 'sprites'
    t.ok sprite = all_sprites.find_child(), 'sprite'
    console.log 'sprite', sprite, sprite.get_raw('x'), my.inspect(sprite)
    t.equal sprite.get('position').all().toString(), "2,2", 'sprite position'
    t.ok sprite.get('x') > 0, 'non-zero x'
    t.end()

