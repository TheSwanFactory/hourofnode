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
  world = load(rx, {game: 'example', level: 1})
  window.bl = world
  level = world.find_child()
  grid = level.find_child('grid')
  all_sprites = grid.find_child('sprites')
  pad = all_sprites.find_children()[0]
  sprite = all_sprites.find_children()[1] # me
  wall = all_sprites.find_children()[2]

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
    t.equal world.get('game'), 'example', 'game file'
    t.equal world.get('level_index'), 1, 'first level'
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
    transform_result =
      transform:        "translate(#{size}px,#{size}px) rotate(0deg)"
      transform_origin: "#{c}px #{c}px"

    test_position t, [1,1]
    t.ok sprite.get('x') > 0, 'non-zero x'
    t.ok sprite.get('y') > 0, 'non-zero y'
    t.equal sprite.get('transform').transform, transform_result.transform, 'transform'
    t.equal sprite.get('transform').transform_origin, transform_result.transform_origin, 'transform'
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
    t.end()

  test "find actions", (t) ->
    t.ok actions = sprite.get('actions'), 'actions'
    t.ok commands = actions.keys([]), 'actions'
    t.ok "forward" in commands, 'has a command'
    t.end()

  test "find sequences", (t) ->
    t.ok actions = sprite.get('actions'), 'actions'
    t.ok sequences = actions.keys(), 'actions'
    t.end()

  test 'law - moving into obstruction', (t) ->
    # set up a collision
    sprite.put 'next_position', wall.get('position')
    t.equal sprite.get('proposed_position'),
            wall.get('proposed_position'),
            'impending collision'

    sprite.send 'fetch'
    sprite.send 'execute'

    t.equal sprite.get('next_position'),
            undefined,
            'sprite next position should clear'
    t.notEqual sprite.get('position'),
               wall.get('position'),
               'sprite did not move onto the wall'
    t.ok sprite.get('bump'), 'sprite was bumped'

    sprite.send 'prefetch'

    t.equal sprite.get('running'), 'bump', 'sprite runs bump'
    t.false sprite.get('bump'), 'sprite bump gets cleared'

    sprite.send 'step'

    t.equal sprite.get('running'), 'run', 'sprite returns to run after one action'
    t.end()

  test 'law - moving into non-obstruction', (t) ->
    # sprite moves onto pad
    sprite.put 'next_position', pad.get('position')
    t.equal pad.get('proposed_position'),
            pad.get('position'),
            'pad not moving'
    t.equal sprite.get('proposed_position'),
            pad.get('proposed_position'),
            'impending collision'

    sprite.send 'execute'

    t.equal sprite.get('position'),
            pad.get('position'),
            'sprite moved onto pad'
    t.notOk sprite.get('bump'), 'sprite was not bumped'
    t.ok pad.get('bump'), 'pad was bumped'

    sprite.send 'prefetch'

    t.equal sprite.get('running'), 'run', 'sprite running'
    t.equal pad.get('running'), 'bump', 'pad bumping'
    t.end()

  test 'law - collision with edge of grid', (t) ->
    sprite.put 'bump', null

    edge = [7, 7]
    sprite.put 'next_position', edge
    sprite.send 'execute'

    t.deepEqual sprite.get('position').all(), edge, 'should move to edge'

    out_of_x_bounds = [8, 0]
    sprite.put 'next_position', _.clone(out_of_x_bounds)
    sprite.send 'execute'
    t.notEqual sprite.get('position').all(), out_of_x_bounds, 'should not move off grid'
    t.true("grid" in sprite.get('bump').all(), 'bumped by grid')

    sprite.put 'bump', null

    out_of_y_bounds = [0, 8]
    sprite.put 'next_position', _.clone(out_of_y_bounds)
    sprite.send 'execute'
    t.notEqual sprite.get('position').all(), out_of_y_bounds, 'should not move off grid'
    t.true("grid" in sprite.get('bump').all(), 'bumped by grid')
    t.end()
