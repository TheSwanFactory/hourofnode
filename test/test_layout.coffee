{my} = require '../src/my'
{load} = require '../src/load'
{god} = require '../src/god'

{layout} = require '../src/layout'
{header} = require '../src/layout/header'
{controls} = require '../src/layout/controls'
{grid} = require '../src/layout/grid'
{sprites} = require '../src/layout/sprites'

{behavior} = require '../src/layout/mixins/behavior'

exports.test_layout = ->
  describe 'Layout', ->
    world = load(rx, {game: 'example', level: 1})
    window.bl = world
    level = world.find_child()
    grid = level.find_child('grid')
    all_sprites = grid.find_child('sprites')
    pad = all_sprites.find_children()[0]
    sprite = all_sprites.find_children()[1] # me
    log = all_sprites.find_children()[2]

    it "layout", ->
      assert.ok header, 'header'
      assert.ok controls, 'controls'
      assert.ok grid, 'grid'
      assert.ok world, 'world'

    it "layout properties", ->
      assert.ok shapes = world.get('shapes'), 'shapes'
      assert.ok levels = world.get('levels'), 'levels'
      assert.ok world.is_array(levels), 'levels rx_array'

      assert.ok level = world._child_array()[0], 'active level'
      assert.ok sprites = level.get('sprites'), 'sprites'
      assert.ok world.is_array(sprites), 'sprites rx_array'
      assert.ok sprite_dict = sprites.at(0), 'sprite'

    it "layout world", ->
      assert.ok level, 'active level'
      assert.equal world.get('game'), 'example', 'game file'
      assert.equal world.get('level_index'), 1, 'first level'
      assert.ok grid, 'grid'
      assert.ok all_sprites, 'sprites'
      assert.ok sprite, 'sprite'

    test_position = (pos) ->
      position_string = sprite.get('position').all().toString()
      pos_string = pos.toString()
      assert.equal position_string, pos_string, "sprite position should be: #{pos}"

    it "layout sprite", ->
      size = 64
      c = size / 2
      transform_result =
        transform:        "translate(#{size}px,#{size}px) rotate(0deg)"
        transform_origin: "#{c}px #{c}px"

      test_position [1,1]
      assert.ok sprite.get('x') > 0, 'non-zero x'
      assert.ok sprite.get('y') > 0, 'non-zero y'
      assert.equal sprite.get('transform').transform, transform_result.transform, 'transform'
      assert.equal sprite.get('transform').transform_origin, transform_result.transform_origin, 'transform'
      assert.equal sprite.get('stroke'), 'black', 'stroke'
      assert.equal sprite.get('fill'), 'blue', 'fill'

    it "command sprite", ->
      assert.ok sprite.get('position'), "sprite position"
      test_position [1,1]
      sprite.call('go', 1)
      sprite.call 'commit'
      test_position [2,1]
      sprite.call('go', -1)
      sprite.call 'commit'
      test_position [1,1]

    it "find actions", ->
      assert.ok actions = sprite.get('actions'), 'actions'
      assert.ok commands = actions.keys([]), 'actions'
      assert.ok "forward" in commands, 'has a command'

    it "find sequences", ->
      assert.ok actions = sprite.get('actions'), 'actions'
      assert.ok sequences = actions.keys(), 'actions'

    it 'law - moving into obstruction', ->
      # set up a collision
      sprite.put 'next_position', log.get('position')
      assert.equal sprite.get('proposed_position'),
              log.get('proposed_position'),
              'impending collision'

      sprite.send 'fetch'
      sprite.send 'execute'

      assert.equal sprite.get('next_position'),
              undefined,
              'sprite next position should clear'
      assert.notEqual sprite.get('position'),
                 log.get('position'),
                 'sprite did not move onto the log'
      assert.ok sprite.get('bump'), 'sprite was bumped'
      assert.notOk log.get('bump'), 'log was not bumped'

      sprite.send 'prefetch'

      assert.equal sprite.get('running'), 'bump', 'sprite runs bump'
      assert.false sprite.get('bump'), 'sprite bump gets cleared'

      sprite.send 'step'

      assert.equal sprite.get('running'), 'run', 'sprite returns to run after one action'

    it 'law - moving into non-obstruction', ->
      # sprite moves onto pad
      sprite.put 'next_position', pad.get('position')
      assert.equal pad.get('proposed_position'),
              pad.get('position'),
              'pad not moving'
      assert.equal sprite.get('proposed_position'),
              pad.get('proposed_position'),
              'impending collision'

      sprite.send 'execute'

      assert.equal sprite.get('position'),
              pad.get('position'),
              'sprite moved onto pad'
      assert.notOk sprite.get('bump'), 'sprite was not bumped'
      assert.ok pad.get('bump'), 'pad was bumped'

      sprite.send 'prefetch'

      assert.equal sprite.get('running'), 'run', 'sprite running'
      assert.equal pad.get('running'), 'bump', 'pad bumping'

    it 'law - collision with edge of grid', ->
      sprite.put 'bump', null

      edge = [7, 7]
      sprite.put 'next_position', edge
      sprite.send 'execute'

      assert.deepEqual sprite.get('position').all(), edge, 'should move to edge'

      out_of_x_bounds = [8, 0]
      sprite.put 'next_position', _.clone(out_of_x_bounds)
      sprite.send 'execute'
      assert.notEqual sprite.get('position').all(), out_of_x_bounds, 'should not move off grid'
      assert.true("grid" in sprite.get('bump').all(), 'bumped by grid')

      sprite.put 'bump', null

      out_of_y_bounds = [0, 8]
      sprite.put 'next_position', _.clone(out_of_y_bounds)
      sprite.send 'execute'
      assert.notEqual sprite.get('position').all(), out_of_y_bounds, 'should not move off grid'
      assert.true("grid" in sprite.get('bump').all(), 'bumped by grid')
