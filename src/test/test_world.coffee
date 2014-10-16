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

  test 'world has children', (t) ->
    world.add_child("Anjali")
    result = world.map_child (child) -> "#{child} Prabhakar"
    t.equal result[0], "Anjali Prabhakar", "add/map child"
    t.end()

  test 'world creates world for dictionaries', (t) ->
    t.fail()
    t.end()
