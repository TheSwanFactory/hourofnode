{god} = require('../god')

exports.test_world = (test, rx) ->
  world = god(rx, {key: "value"})
  test 'world exists', (t) ->
    t.ok world, "world"
    t.end()

    
  test 'world stores primitives faithfully', (t) ->
    test_store = (key, value) ->
      world.put(key, value)
      result = world.get(key)
      t.equal result, value
    test_store(t, "number", 2)
    test_store(t, "string", "okay")
    test_store(t, "array", [1, "b"])
    t.end()

  test 'world iterates over children', (t) ->
    t.ok world.add_child, "add_child"
    t.ok world.map_child, "map_child"
    t.end()
