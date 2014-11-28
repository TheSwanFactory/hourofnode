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
    test_store("dict", {not: "2b"})
    t.end()

  test 'world stores arrays as reactive', (t) ->
    key = "array"
    value = [1, "2b"]
    world.put(key, value)
    result = world.get(key)
    t.equal result.all().toString(), value.toString(), "store #{key}"
    t.end()

  test 'world can update properties', (t) ->
    world.put('x', 2)
    world.update('x', 1)
    t.equal world.get('x'), 3
    t.end()
    
  test 'world contains reactive extensions', (t) ->
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
    t.ok world.is_array(children), "children is SrcArray"
    child = children.at(0)
    t.ok child, "child exists"
    t.ok world.is_world(child), "child is a world"
    t.end()

  test 'world returns keys', (t) ->
    new_world = world.make_world {a: 1, b:2, _CHILDREN:[{c:3}]}
    t.equal new_world.keys().toString(), ['a', 'b'].toString(), 'my keys'
    new_child = new_world.find_child()
    t.equal new_child.keys().toString(), ['c'].toString(), 'child keys'
    t.equal new_child.keys([]).toString(), ['a', 'b', 'c'].toString(), 'all keys'
    t.end()

  test 'world has a label', (t) ->
    t.equal world.label(), "root", "label"
    t.equal "#{world}", "World_root", "toString"
    t.end()
    
  test 'world can find children', (t) ->
    t.ok world.has_children(), "has some"
    result = world.find_children()
    t.ok result, "finds children"
    t.equal result.length, 1, "1 child"

    result = world.find_children("root")
    t.equal result.length, 0, "0 child"
    console.log 'find children', world, world._child_array()
    result = world.find_children("root-0")
    t.equal result.length, 1, "1 child"
    t.end()
    
  test 'world can replace children', (t) ->
    label = 'root-0'
    t.equal world.find_index(label), 0, "find_index"
    original_count = world._child_count()
    t.equal world.find_child(label).get('c'), 3
    replacement = {_LABEL: label, c: 9}
    world.replace_child(replacement)
    t.equal world.find_child(label).get('c'), 9
    t.equal world._child_count(), original_count, "changed count"
    t.end()
    
  # TODO: Break this up into smaller tests somehow
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
    t.equal result[0], "Anjali Prabhakar", "map child"
    t.equal daughter.find_parent("Premela"), grandma, 'Find ancestor'
    t.equal daughter.find_parent("Abraham"), world, 'Unknown ancestor'
    
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

    t.ok world.label() == "root", "equals root"
    t.ok daughter.find_parent("root"), "find_parent root"
    t.equal world, world.find_path('.'), "find root"
    t.equal world, daughter.find_path('.'), "find root from below"
    t.equal mom.find_path('Anjali'), daughter, "find child"
    t.equal daughter.find_path('.Premela'), grandma, "find ancestor"

    t.equal world.find_path('.Premela.Sandhya.Anjali'), daughter, "find path"

    #t.equal daughter.find_any('Premela'), grandma, "find any ancestor"
    #t.equal grandma.find_any('Anjali'), daughter, "find any descendant"
    t.end()

  test 'world passes index as property when mapping', (t) ->
    count = 0
    world.map_children (child) ->
      index = child.index
      t.equal index, count, "#{child} should have index #{count}, not #{index}"
      count = count + 1
    t.end()

  test 'world removes child at index', (t) ->
    a = world.add_child('a')
    b = world.add_child('b')
    world.map_children (child) ->
      "just to set index"
    count = world._child_count()
    t.ok a.index, "a has index"
    world.remove_child a
    t.equal world._child_count(), count - 1
    t.end()
    
  test 'world has authorities', (t) ->
    comply = world._spawn_world("compliant")
    authority = world._spawn_world("authority")
    rebel = world._spawn_world("rebellious")
    rebel.put("_AUTHORITY", authority)
    
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
    callme = (world, args) -> [world.get("instance"), args['key']]
    world.put('callme', callme)
    result = world.call('callme', args)
    t.equal result[0], "variable", "world parameter"
    t.equal result[1], "value", "args parameter"
    t.end()

  test 'world knows worlds', (t) ->
    t.ok world.is_world(world), "non-world"
    t.notOk world.is_world(1), "non-world"
    t.ok world.is_root(), "is root"
    branch = world.add_child("branch")
    t.notOk branch.is_root(), "is not root"
    t.end()
    
  test 'world generates CSS labels', (t) ->
    daughter = world.add_child("daughter")
    daughter.put("_CSS", "klass")
    css = daughter.labels(["css"])
    t.ok css.length > 2, "Traverse label hierarchy"
    t.ok "klass" in css, "Has explicit class"
    t.ok "root" in css, "Has root"
    t.end()

  test 'config handlers', (t) ->
    t.equal world.handlers_for('begin').length, 0, "1 begin handler"
    begun = false
    finished = false
    world.handle 'begin', -> begun = true
    t.equal world.handlers_for('begin').length, 1, "1 begin handler"
    t.equal world.handlers_for('finish').length, 0, "0 finish handler"
    world.handle 'finish', -> finished = true
    t.equal world.handlers_for('finish').length, 1, "0 finish handler"

    t.notOk begun, "Has not ran"
    t.notOk finished , "Has not finished"
    world.send 'begin'
    t.ok begun, "Has begun"
    world.send 'finish'
    t.ok finished, "Has finished"
    t.end()

  test 'event callbacks', (t) ->
    val = 42
    t.notOk world.get('property'), "no property yet"
    world.handle 'value', (key, args) -> args
    world.send 'value', val, (value) -> world.put('property', value)
    t.equal world.get('property'), val, "property not set"
    t.end()
