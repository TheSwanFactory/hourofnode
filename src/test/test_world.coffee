{world} = require('../world')

exports.test_world = (test, rx) ->
  test 'world factory exists', (t) ->
    t.ok world
    t.end()
