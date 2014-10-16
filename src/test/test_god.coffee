{god} = require('../god')

exports.test_god = (test, rx) ->
  test 'god exists', (t) ->
    t.ok god
    t.end()

  test 'god creates a world', (t) ->
    console.log(rx)
    world = god(rx, {key: "value"})
    t.ok world
    t.end()
    