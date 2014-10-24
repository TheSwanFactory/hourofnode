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

  test 'world can update properties', (t) ->
    world.put('x', 2)
    world.update('x', 1)
    t.equal world.get('x'), 3
    t.end()
    
  test 'world contains rx', (t) ->
    t.ok world.rx(), "rx()"
    t.ok world.T(), "T"
    t.ok world.SVG() ,"SVG"
    t.ok world.bind(), "bind"
    t.end()

  test 'world makes sub-worlds', (t) ->
    value = "42"
    sub = world.make_world(value)
    t.equal sub.get("value"), value, "sub.get"
    t.equal sub.up, world, "sub.up"
    t.equal sub.get('up'), world, "sub.get('up')"
    t.ok sub.T(), "sub.T"
    
    dict = {key: value}
    sub_m = world.make_world(dict)
    t.equal sub_m.get("key"), value, "sub_d.get"
    
    sub_w = world.make_world(world)
    t.equal sub_w, world, "don't wrap worlds"
    t.end()

  test 'world imports from dictionaries', (t) ->
    world.import_dict({a: 1, b:2, _CHILDREN:[{c:3}]})
    t.equal world.get('a'), 1, "import properties"
    children = world.get('_CHILDREN')
    t.ok children instanceof rx.SrcArray, "children is SrcArray"
    child = children.at(0)
    t.ok child, "child exists"
    t.ok world.is_world(child), "child is a world"
    t.end()

  test 'world has a label', (t) ->
    t.equal world.label(), "root", "label"
    t.equal "#{world}", "World_root", "toString"
    t.end()
    
  test 'world can find children', (t) ->
    t.ok world.has_children(), "has some"
    result = world.find_children()
    console.log result
    t.ok result, "finds children"
    t.equal result.length, 1

    result = world.find_children("root")
    t.equal result.length, 0
    result = world.find_children("root:0")
    t.equal result.length, 1
    t.end()
    
  test 'world has children inherit', (t) ->
    t.ok world.has_children(), "world.has_children"
    grandma = world.add_child("Premela")
    t.notOk grandma.has_children(), "grandma.has_children NOT"
    mom = grandma.add_child("Sandhya")
    t.ok grandma.has_children(), "grandma.has_children"
    daughter = mom.add_child("Anjali")
    t.ok mom.has_children(), "mom.has_children"
    t.ok daughter, "daughter"
    t.equal "#{daughter}", "World_Anjali", "daughter name"
    result = mom.map_children (child) -> "#{child.label()} Prabhakar"
    t.equal result.at(0), "Anjali Prabhakar", "map child"
    t.equal daughter.find_parent("Premela"), grandma, 'Find ancestor'
    t.notOk daughter.find_parent("Abraham"),'Unknown ancestor'
    candy = 'chocolate'
    
    t.notOk daughter.get(candy), "No chocolate"

    t.notOk daughter.owner(candy), "No chocolate owner"
    grandma.put(candy, 'dark')
    t.equal grandma.owner(candy), grandma, "chocolate owner self"
    t.equal daughter.owner(candy), grandma, "chocolate owner"
    t.equal daughter.get(candy), 'dark', "Inherit chocolate"
    
    mom.put(candy, 0)
    t.equal daughter.owner(candy), mom, "chocolate owner 0"
    t.equal daughter.get(candy), 0, "Inherit chocolate 0"
    
    css = daughter.labels(["css"])
    t.ok css.length > 2, "Traverse label hierarchy"
    t.equal css[css.length-1], "root", "Reach label root"
    t.end()

  test 'world passes index when mapping', (t) ->
    count = 0
    world.map_children (child) ->
      index = child.get('_INDEX')
      t.equal index, count, "#{child} should have index #{count}, not #{index}"
      count = count + 1
    t.end()

  test 'world imports functions for children', (t) ->
    result = world._import_children([{a:1}])
    child = result.at(0)
    t.ok world.is_world(child), "creates child from dict"
    generator = (world) -> [{b:2}]
    result = world._import_children(generator)
    child = result(world).at(0)
    t.ok world.is_world(child), "creates child from dict"  
    t.end()
    
  test 'world has authorities', (t) ->
    comply = world._spawn_world("compliant")
    authority = world._spawn_world("authority")
    world.put("_AUTHORITY", authority)
    rebel = world._spawn_world("rebellious")
    
    world.put("foo", "bar")
    t.equal comply.get('foo'), 'bar', 'comply foo'
    t.equal rebel.get('foo'), 'bar', 'rebel foo'
    authority.put('foo', 'baz')
    t.equal comply.get('foo'), 'bar', 'comply foo'
    t.equal rebel.get('foo'), 'baz', 'rebel foo with authority'    
    t.end()
    
  test 'world has dynamic properties', (t) ->
    value = "wanna"
    world.put("fun", -> value)
    t.equal typeof world.get_raw("fun"), 'function', "raw function"
    t.equal world.get("fun"), value, "dynamic property"
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

  test 'world knows worlds', (t) ->
    t.ok world.is_world(world), "non-world"
    t.notOk world.is_world(1), "non-world"
    t.end()
