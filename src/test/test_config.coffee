{god} = require('../god')
{config} = require('../config')

exports.test_config = (test, rx) ->
  world = god(rx, config)
  
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
    world.map_children ->
      count = count + 1
    t.ok count > 2, "count children"
    t.end()

  test 'config game', (t) ->
    t.ok world.find_path('.game'), "game"
    t.ok world.send('.game', world), "send game"
    
    t.end()

  test 'config program', (t) ->
    context = world.find_path('.inspector.program_loader.conflict')
    t.ok context, "context"
    program = context.get('program')
    console.log "program", program
    t.ok world.is_array(program), "program is array"
    t.end()
