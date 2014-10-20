{god} = require('../god')
{config} = require('../config')

exports.test_config = (test, rx) ->
  world = god(rx, config)
  
  test 'config read', (t) ->
    t.ok world.get('size'), 'size'
    t.ok world.get('scale') > 10, 'scale'
    t.end()

  test 'config children', (t) ->
    count = 0
    world.map_children ->
      count = count + 1
    t.equal count, 3, "count children"
    t.end()

  test 'config rx', (t) ->
    t.ok world.bind, "bind"
    t.end()
