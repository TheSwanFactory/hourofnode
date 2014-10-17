{god} = require('../god')
{config} = require('../config')

exports.test_config = (test, rx) ->
  world = god(rx, config)
  
  test 'world exists', (t) ->
    t.ok world
    t.end()
