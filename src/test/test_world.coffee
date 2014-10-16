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
      t.equal result, value, "store #{key}"
    test_store("number", 2)
    test_store("string", "okay")
    test_store("array", [1, "b"])
    t.end()

  test 'world iterates over children', (t) ->
    t.ok world.add_child, "add_child"
    value = "Anjali"
    world.add_child(value)
    
    t.ok world.map_child, "map_child"

    result = world.map_child (child) -> "#{child} Prabhakar"
    t.equal result[0], "Anjali Prabhakar"
    t.end()
