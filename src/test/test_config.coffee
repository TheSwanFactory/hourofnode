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
    t.equal count, 3, "count children"
    t.end()

  test 'config program', (t) ->
    context = world.find('.controls.program_loader.conflict')
    t.ok context, "context"
    console.log context
    program = context.get_raw('program')
    console.log program
    t.ok _.isArray program
    t.end()
