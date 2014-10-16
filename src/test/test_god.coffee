{god} = require('../god')

exports.test_god = (test, rx) ->
  test 'god exists', (t) ->
    t.ok god
    t.end()

  test 'god gets external reality', (t) ->
    t.ok god.get_raw
    t.ok god.get_raw('anything else')
    t.end()

  test 'god creates a world', (t) ->
    console.log(rx)
    #world = god(rx, {})
    t.ok world
    t.end()
    