{god} = require('../god')
{config} = require('../config')

exports.test_config = (test, rx) ->
  world = god(rx, config)
  layout = world.find_child 'layout'
  sprites = layout.find_path('grid.sprites')
  current = sprites.find_child()
  sprite = current

  test 'config init', (t) ->
    t.ok world, 'world'
    t.ok layout, 'layout'
    t.ok sprites , 'sprites'
    t.ok current, 'current '
    t.end()
  
  test 'config read', (t) ->
    t.ok world.get('size'), 'size'
    t.ok world.get('scale') > 10, 'scale'
    t.end()

  test 'config rx', (t) ->
    t.ok world.bind, "bind"
    t.end()

  test 'config transform', (t) ->
    t.equal 0, layout.get('i'), 'i'
    t.equal layout.get('transform'), "translate(0,0) rotate(0)"
    t.end()

  test 'config children', (t) ->
    count = 0
    world.map_children -> count = count + 1
    t.ok count > 1, "count children"
    t.ok current, "require current turtle"
    t.end()

  test 'config my parameters', (t) ->
    t.ok world.get('device'), "device"
    t.end()

  test 'config program', (t) ->
    dict = {default: ['forward'], buffer: []}
    r = {programs: ''}
    world.send 'programs', dict, (value) -> r.programs = value
    t.ok r.programs, 'Returns programs'
    store = r.programs
    t.ok store = current.get('programs'), "program store"
    t.ok signal_1 = store.call('load'), "load program"
    t.ok signal_2 = store.call('reload'), "reload program "
    t.ok signal_3 = current.call('next_signal'), "next signal"
    #t.equal signal_1['do'], 'go', ""

    t.ok other = turtles.find_child('EP'), "other turtle"
    t.ok store2 = other.get('programs'), "other program"
    t.notOk store2 == store, "Don't reuse program"
    t.end()

  test 'config sprite', (t) ->
    t.ok sprites = layout.find_path('grid.sprites'), "find sprites"
    t.ok sprite = sprites.find_child(), "missing sprite"
    
    world.send('reset')
    t.equal sprite.get('v').all().toString(), "1,0", "sprite has direction vector"
    t.equal sprite.get('p').all().toString(), "1,3", "sprite has direction vector"
    t.equal sprite.get('p_index'), 25, "creates index for p"
    
    sprite.call('go', {dir:1})
    t.equal sprite.get('i'), 2, "sprite moves position"
    t.skip sprite.get('p_index'), 10, "updates index for p"
    sprite.call('turn', {dir:-1})
    t.equal sprite.get('v_j'), 1, "sprite changes direction"
    
    world.send('reset')
    t.equal sprite.get('i'), 1, "sprite has original position"
    t.equal sprite.get('v_i'), 1, "sprite has original direction"
    t.end()

  test 'config timer', (t) ->
    t.ok timer = world.find_path('.timer'), "Got timer"
    t.equal world.handlers_for('run').length, 1, "1 run handler"
    t.equal world.handlers_for('stop').length, 1, "1 stop handler"
    t.equal timer.get('speed'), 0, 'Speed 0'
    result = world.send('run')
    t.equal result.length, 1, '1 handler'
    t.equal timer.get('speed'), 1, 'Speed 1'
    result = world.send('stop')
    t.end()

  test 'config game', (t) ->
    t.ok game = world.get('game'), 'loaded game'
    t.ok paths = game.kinds.turtle.path, 'paths'
    t.end()
