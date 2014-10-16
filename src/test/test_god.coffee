{god} = require('../god')

exports.test_god = (test, rx) ->
  test 'god exists', (t) ->
    t.ok god
    t.end()

  test 'god creates root world', (t) ->
    console.log(rx)
    world = god(rx, {key: "value"})
    t.ok world
    t.equal world.get("key"), "value"
    t.end()
    