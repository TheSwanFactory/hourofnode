{god} = require('../god')

exports.test_world = (test, rx) ->
  world = god(rx, {key: "value"})
  test 'world exists', (t) ->
    t.ok world, "world"
    t.end()
    
  test 'world stores values faithfully', (t) ->
    test_store = (key, value) ->
      world.put(key, value)
      result = world.get(key)
      t.equal result, value, "store #{key}"
    test_store("number", 2)
    test_store("string", "okay")
    test_store("array", [1, "2b"])
    test_store("dict", {not: "2b"})
    t.end()

  test 'world contains rx', (t) ->
    t.ok world.rx(), "rx()"
    t.ok world.T(), "T"
    t.ok world.SVG() ,"SVG"
    t.ok world.bind(), "bind"
    t.end()

  test 'world makes sub-worlds', (t) ->
    value = 42
    sub = world.make_world(value)
    t.equal sub.get("value"), value, "sub.get"
    t.equal sub.up, world, "sub.up"
    t.ok sub.T(), "sub.T"
    
    dict = {key: value}
    sub_m = world.make_world(dict)
    t.equal sub_m.get("key"), value, "sub_d.get"
    t.end()
    
  test 'world imports from dictionaries', (t) ->
    world.import_dict({a: 1, b:2})
    t.equal world.get('a'), 1, "import properties"
    t.end() 

  test 'world has children inherit', (t) ->
    grandma = world.add_child("Premela")
    mom = grandma.add_child("Sandhya")
    daughter = mom.add_child("Anjali")
    t.ok daughter, "daughter"
    result = mom.map_child (child) -> "#{child.get('value')} Prabhakar"
    t.equal result[0], "Anjali Prabhakar", "add/map child"
    
    t.notOk daughter.get('chocolate'), "No chocolate"
    grandma.put('chocolate', 'dark')
    t.equal daughter.get('chocolate'), 'dark', "Inherit chocolate"
    t.end()
    
  test 'world can update properties', (t) ->
    world.put('x', 2)
    world.update('x', 1)
    t.equal world.get('x'), 3
    t.end()
    
  test 'world has dynamic properties', (t) ->
    value = "wanna"
    world.put("fun", -> value)
    t.equal typeof world.get_raw("fun"), 'function', "raw function"
    t.equal world.get("fun"), value, "dynamic property"
    t.end()
    
  test 'world has a label', (t) ->
    t.equal "#{world}", "World:root", "label"
    t.end()

  test 'world can call functions', (t) ->
    world.put("instance", "variable")
    args = {key: "value"}
    
    callme = (world, args) ->
      [world.get("instance"), args['key']]
    world.put('callme', callme)
    result = world.call('callme', args)
    t.equal result[0], "variable", "world parameter"
    t.equal result[1], "value", "args parameter"
    t.end()

