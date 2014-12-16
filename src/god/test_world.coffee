{god} = require('../god')

exports.test_world = ->
  describe 'World', ->
    world = god(rx, {key: "value"})

    it 'world exists', ->
      assert.ok world, "world"
      
    it 'world stores values faithfully', ->
      test_store = (key, value) ->
        world.put(key, value)
        result = world.get(key)
        assert.equal result, value, "store #{key}"
      test_store("number", 2)
      test_store("string", "okay")
      test_store("dict", {not: "2b"})

    it 'world stores arrays as reactive', ->
      key = "array"
      value = [1, "2b"]
      world.put(key, value)
      result = world.get(key)
      assert.equal result.all().toString(), value.toString(), "store #{key}"

    it 'world can update properties', ->
      world.put('x', 2)
      world.update('x', 1)
      assert.equal world.get('x'), 3
      
    it 'world contains reactive extensions', ->
      assert.ok world.rx(), "rx()"
      assert.ok world.T(), "T"
      assert.ok world.SVG() ,"SVG"
      assert.ok world.bind(), "bind"

    it 'world makes sub-worlds', ->
      value = "42"
      sub = world.make_world(value)
      assert.equal sub.get("value"), value, "sub.get"
      assert.equal sub.up, world, "sub.up"
      assert.equal sub.get('up'), world, "sub.get('up')"
      assert.ok sub.T(), "sub.T"
      
      dict = {key: value}
      sub_m = world.make_world(dict)
      assert.equal sub_m.get("key"), value, "sub_d.get"
      
      sub_w = world.make_world(world)
      assert.equal sub_w, world, "don't wrap worlds"

    it 'world imports from dictionaries', ->
      world.import_dict({a: 1, b:2, _CHILDREN:[{c:3}]})
      assert.equal world.get('a'), 1, "import properties"
      children = world.get('_CHILDREN')
      assert.ok world.is_array(children), "children is SrcArray"
      child = children.at(0)
      assert.ok child, "child exists"
      assert.ok world.is_world(child), "child is a world"

    it 'world returns keys', ->
      new_world = world.make_world {a: 1, b:2, _CHILDREN:[{c:3}]}
      assert.equal new_world.keys().toString(), ['a', 'b'].toString(), 'my keys'
      new_child = new_world.find_child()
      assert.equal new_child.keys().toString(), ['c'].toString(), 'child keys'
      assert.equal new_child.keys([]).toString(), ['a', 'b', 'c'].toString(), 'all keys'

    it 'world has a label', ->
      assert.equal world.label(), "root", "label"
      assert.equal "#{world}", "World_root", "toString"
      
    it 'world can find children', ->
      assert.ok world.has_children(), "has some"
      result = world.find_children()
      assert.ok result, "finds children"
      assert.equal result.length, 1, "1 child"

      result = world.find_children("root")
      assert.equal result.length, 0, "0 child"
      result = world.find_children("root-0")
      assert.equal result.length, 1, "1 child"
      
    it 'world can replace children', ->
      label = 'root-0'
      assert.equal world.find_index(label), 0, "find_index"
      original_count = world._child_count()
      assert.equal world.find_child(label).get('c'), 3
      replacement = {_LABEL: label, c: 9}
      world.replace_child(replacement)
      assert.equal world.find_child(label).get('c'), 9
      assert.equal world._child_count(), original_count, "changed count"
      
    # TODO: Break this up into smaller tests somehow
    it 'world has children inherit', ->
      assert.ok world.has_children(), "world.has_children"
      grandma = world.add_child("Premela")
      assert.notOk grandma.has_children(), "grandma.has_children NOT"
      mom = grandma.add_child("Sandhya")
      assert.ok grandma.has_children(), "grandma.has_children"
      daughter = mom.add_child("Anjali")
      assert.ok mom.has_children(), "mom.has_children"
      assert.ok daughter, "daughter"
      assert.equal "#{daughter}", "World_Anjali", "daughter name"
      result = mom.map_children (child) -> "#{child.label()} Prabhakar"
      assert.equal result[0], "Anjali Prabhakar", "map child"
      assert.equal daughter.find_parent("Premela"), grandma, 'Find ancestor'
      assert.equal daughter.find_parent("Abraham"), world, 'Unknown ancestor'
      
      candy = 'chocolate'
      assert.notOk daughter.get(candy), "No chocolate"
      assert.notOk daughter.owner(candy), "No chocolate owner"
      grandma.put(candy, 'dark')
      assert.equal grandma.owner(candy), grandma, "chocolate owner self"
      assert.equal daughter.owner(candy), grandma, "chocolate owner"
      assert.equal daughter.get(candy), 'dark', "Inherit chocolate"
      mom.put(candy, 0)
      assert.equal daughter.owner(candy), mom, "chocolate owner 0"
      assert.equal daughter.get(candy), 0, "Inherit chocolate 0"

      assert.ok world.label() == "root", "equals root"
      assert.ok daughter.find_parent("root"), "find_parent root"
      assert.equal world, world.find_path('.'), "find root"
      assert.equal world, daughter.find_path('.'), "find root from below"
      assert.equal mom.find_path('Anjali'), daughter, "find child"
      assert.equal daughter.find_path('.Premela'), grandma, "find ancestor"

      assert.equal world.find_path('.Premela.Sandhya.Anjali'), daughter, "find path"

      #t.equal daughter.find_any('Premela'), grandma, "find any ancestor"
      #t.equal grandma.find_any('Anjali'), daughter, "find any descendant"

    it 'world passes index as property when mapping', ->
      count = 0
      world.map_children (child) ->
        index = child.index
        assert.equal index, count, "#{child} should have index #{count}, not #{index}"
        count = count + 1

    it 'world removes child at index', ->
      a = world.add_child('a')
      b = world.add_child('b')
      a2 = world.add_child('a')
      world.map_children (child) -> "just to set index"
      count = world._child_count()
      assert.ok a.index, "a has index"
      world.remove_child a2
      assert.equal world._child_count(), count - 1
      world.remove_child a
      assert.equal world._child_count(), count - 2
      
    it 'world has authorities', ->
      comply = world._spawn_world("compliant")
      authority = world._spawn_world("authority")
      rebel = world._spawn_world("rebellious")
      rebel.put("_AUTHORITY", authority)
      
      world.put("foo", "bar")
      assert.equal comply.get('foo'), 'bar', 'comply foo'
      assert.equal rebel.get('foo'), 'bar', 'rebel foo'
      authority.put('foo', 'baz')
      assert.equal comply.get('foo'), 'bar', 'comply foo'
      assert.equal rebel.get('foo'), 'baz', 'rebel foo with authority'    
      
    it 'world has dynamic properties', ->
      value = "wanna"
      world.put("fun", -> value)
      assert.equal typeof world.get_raw("fun"), 'function', "raw function"
      assert.equal world.get("fun"), value, "dynamic property"

    it 'world can call functions', ->
      world.put("instance", "variable")
      args = {key: "value"}
      callme = (world, args) -> [world.get("instance"), args['key']]
      world.put('callme', callme)
      result = world.call('callme', args)
      assert.equal result[0], "variable", "world parameter"
      assert.equal result[1], "value", "args parameter"

    it 'world knows worlds', ->
      assert.ok world.is_world(world), "non-world"
      assert.notOk world.is_world(1), "non-world"
      assert.ok world.is_root(), "is root"
      branch = world.add_child("branch")
      assert.notOk branch.is_root(), "is not root"
      
    it 'world generates CSS labels', ->
      daughter = world.add_child("daughter")
      daughter.put("_CSS", "klass")
      css = daughter.labels(["css"])
      assert.ok css.length > 2, "Traverse label hierarchy"
      assert.ok "klass" in css, "Has explicit class"
      assert.ok "root" in css, "Has root"

    it 'config handlers', ->
      assert.equal world.handlers_for('begin').length, 0, "1 begin handler"
      begun = false
      finished = false
      world.handle 'begin', -> begun = true
      assert.equal world.handlers_for('begin').length, 1, "1 begin handler"
      assert.equal world.handlers_for('finish').length, 0, "0 finish handler"
      world.handle 'finish', -> finished = true
      assert.equal world.handlers_for('finish').length, 1, "0 finish handler"

      assert.notOk begun, "Has not ran"
      assert.notOk finished , "Has not finished"
      world.send 'begin'
      assert.ok begun, "Has begun"
      world.send 'finish'
      assert.ok finished, "Has finished"

    it 'event callbacks', ->
      val = 42
      assert.notOk world.get('property'), "no property yet"
      world.handle 'value', (key, args) -> args
      world.send 'value', val, (value) -> world.put('property', value)
      assert.equal world.get('property'), val, "property not set"
