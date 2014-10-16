{god} = require('../god')

exports.test_world = (test, rx) ->
  world = god(rx, {key: "value"})
  test 'world exists', (t) ->
    t.ok world
    t.end()

  test_store = (t, key, value) ->
    world.put(key, value)
    result = world.get(key)
    t.equal result, value
    
  test 'world stores primitives faithfully', (t) ->
    test_store(t, "number", 2)
    test_store(t, "string", "okay")
    test_store(t, "array", [1, "b"])
    t.end()
