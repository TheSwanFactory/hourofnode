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
  level = world.find_child()
  grid = level.find_child('grid')
  all_sprites = grid.find_child('sprites')
  sprite = all_sprites.find_child()

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
  
  test "layout world", (t) ->
    t.ok level, 'active level'
    t.ok grid, 'grid'
    t.ok all_sprites, 'sprites'
    t.ok sprite, 'sprite'
    t.end()

  test "layout sprite", (t) ->
    size = 64
    c = size / 2
    transform_result = "translate(#{size},#{size}) rotate(0 #{c} #{c})"

    t.equal sprite.get('position').all().toString(), "1,1", 'sprite position'
    t.ok sprite.get('x') > 0, 'non-zero x'
    t.ok sprite.get('y') > 0, 'non-zero y'
    t.equal sprite.get('transform'), transform_result , 'transform'
    t.equal sprite.get('stroke'), 'black', 'stroke'
    t.equal sprite.get('fill'), 'blue', 'fill'
    t.end()

  test "layout inspector", (t) ->
    t.ok inspector = sprite.get('inspector'), 'made inspector'
    t.end()

