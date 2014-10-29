{god} = require('../god')
{config} = require('../config')

exports.test_config = (test, rx) ->
  world = god(rx, config)
  turtles = world.find_child('turtles')
  current = turtles.find_child()
  
  test 'config read', (t) ->
    t.ok world.get('size'), 'size'
    t.ok world.get('scale') > 10, 'scale'
    t.end()

  test 'config rx', (t) ->
    t.ok world.bind, "bind"
    t.end()

  test 'config transform', (t) ->
    t.equal 0, world.get('i'), 'i'
    t.equal world.get('transform'), "translate(0,0) rotate(0)"
    t.end()

  test 'config children', (t) ->
    count = 0
    world.map_children -> count = count + 1
    t.ok count > 2, "count children"
    t.ok turtles, "can not find turtles"
    t.ok current, "require current turtle"
    t.end()

  test 'config game', (t) ->
    t.ok game = world.find_path('.game'), "Got game"
    t.equal world.handlers_for('run').length, 1, "1 run handler"
    t.equal world.handlers_for('stop').length, 1, "1 stop handler"
    t.equal game.get('speed'), 0, 'Speed 0'
    result = world.send('run')
    t.equal result.length, 1, '1 handler'
    t.equal game.get('speed'), 1, 'Speed 1'
    result = world.send('stop')
    t.end()

  test 'config sprite', (t) ->
    t.ok sprites = world.find_child('sprites'), "can not find sprites"
    t.ok sprite = sprites.call('NewFromTurtle', current), "missing sprite"
    t.equal sprite.get('i'), 4.5, "sprite has position"
    t.equal sprite.get('v_j'), 1, "sprite has direction"
    t.end()

  test 'config turtle', (t) ->
    t.ok store = current.get('programs'), "program store"
    console.log store
    t.ok action = current.call('next_action'), "Has a valid action"
    console.log action, turtles
    t.end()
