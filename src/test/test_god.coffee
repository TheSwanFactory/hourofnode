{god} = require('../god')
{vector} = require('../vector')

exports.test_god = (test, rx) ->
  test 'god exists', (t) ->
    t.ok god, "god"
    t.end()

  test 'god creates root world', (t) ->
    world = god(rx, {key: "value"})
    t.ok world, "world"
    t.equal world.get("key"), "value"
    t.end()

  test 'vector', (t) ->
    t.end()
    