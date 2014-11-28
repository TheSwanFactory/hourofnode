{my} = require '../my'
{load} = require '../load'
{god} = require '../god'

{layout} = require '../layout'
{header} = require './header'
{controls} = require './controls'
{grid} = require './grid'
{sprites} = require './sprites'

{behavior} = require './mixins/behavior'

exports.test_layout = (test, rx) ->
  world = load(rx, {file: 'example', level: 1})
  level = world.find_child()
  grid = level.find_child('grid')
  all_sprites = grid.find_child('sprites')
  sprite = all_sprites.find_children()[1]

  test "layout", (t) ->
    t.ok header, 'header'
    t.ok controls, 'controls'
    t.ok grid, 'grid'
    t.ok world, 'world'
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
    t.ok sprite.get('position'), "sprite position"
    test_position t, [1,1]
    sprite.call('go', 1)
    sprite.call 'commit'
    test_position t, [2,1]
    sprite.call('go', -1)
    sprite.call 'commit'
    test_position t, [1,1]
    
    #t.notOk sprite.call('apply', {target: grid}), "only apply to self"
    #t.ok forward = sprite.get('actions').get('forward'), 'forward'
    # TODO: redo as behavior
    t.end()

  test "find actions", (t) ->
    #t.ok inspector = sprite.get('inspector'), 'made inspector'
    t.ok actions = sprite.get('actions'), 'actions'
    t.ok actions = actions.keys([]), 'actions'
    t.ok "forward" in actions, 'has a command'
    t.end()

  test "behavior dict", (t) ->
    t.ok behavior = sprite.get('behavior'), 'behavior'
    t.skip ->
      t.ok dict = behavior(sprite)
      t.equal dict.running, 'first', 'running program'    
      t.ok inspect = god(rx, dict), 'create inspector world'
      t.equal inspect.get('running'), 'first', 'running label'
      t.ok program = inspect.get('running_program'), 'get running_program'
      t.ok program.get('is_running'), 'is-running'
    t.end()

