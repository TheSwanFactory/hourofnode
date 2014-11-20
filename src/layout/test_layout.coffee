{my} = require '../my'
{game} = require '../game'
{god} = require '../god'

{layout} = require '../layout'
{header} = require './header'
{controls} = require './controls'
{grid} = require './grid'
{sprites} = require './sprites'

{inspect_behavior} = require './inspect_behavior'

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

  test_position = (t, pos) ->
    position_string = sprite.get('position').all().toString()
    pos_string = pos.toString()
    t.equal position_string, pos_string, "sprite position should be: #{pos}"

  test "layout sprite", (t) ->
    size = 64
    c = size / 2
    transform_result = "translate(#{size},#{size}) rotate(0 #{c} #{c})"

    test_position t, [1,1]
    t.ok sprite.get('x') > 0, 'non-zero x'
    t.ok sprite.get('y') > 0, 'non-zero y'
    t.equal sprite.get('transform'), transform_result , 'transform'
    t.equal sprite.get('stroke'), 'black', 'stroke'
    t.equal sprite.get('fill'), 'blue', 'fill'
    t.end()

  test "command sprite", (t) ->
    test_position t, [1,1]
    sprite.call('go', 1)
    test_position t, [2,1]
    sprite.call('go', -1)
    test_position t, [1,1]
    
    t.notOk sprite.call('apply', {target: grid}), "only apply to self"
    forward = sprite.get('language')['forward']
    message = {target: sprite, action: forward}
    t.ok sprite.call('apply', message), "apply message"
    test_position t, [2,1]
    t.end()

  test "find words", (t) ->
    t.ok inspector = sprite.get('inspector'), 'made inspector'
    t.ok language = sprite.get('language'), 'language'
    t.ok words = Object.keys(language), 'words'
    t.ok "forward" in words, 'has a command'
    t.end()

  test "find behavior", (t) ->
    t.ok behavior = sprite.get('behavior'), 'behavior'
    t.ok dict = inspect_behavior(sprite)
    console.log "find behavior", behavior, dict
    t.end()

