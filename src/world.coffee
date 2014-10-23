assert = require 'assert'

wraparound = (n, max) ->
  return max - 0.5 if n < 0
  return 0.5 if n > max
  n
  
RX = "_RX"
LABEL = "_LABEL"
CHILDREN = "_CHILDREN"
AUTHORITY = "_AUTHORITY"

isFunction = (value) ->
  typeof(value) == "function"

isObject = (value) ->
  typeof(value) == "object"

isString = (value) ->
  typeof(value) == "string"

class World
  constructor: (up, label, rx) ->
    assert up, "up always exists"
    assert isObject(up), "up is an object"
    @up = up
    cache_rx = rx or @up.get_raw(RX)
    assert cache_rx, "cache_rx"
    @doc = cache_rx.map()
    assert isString(label), "label is string"
    @doc.put(LABEL, label)
    @doc.put(CHILDREN, cache_rx.array())
    @doc.put(RX, rx) if rx?
    
  # reactive-coffee tags and binding
  rx: () -> @get(RX)
  T: () -> @rx().rxt.tags
  SVG: () -> @rx().rxt.svg_tags
  bind: () -> @rx().bind
  
  put: (key, value) ->
    @doc.put(key, value)

  get_local: (key) ->
    @doc.get(key)

  get_raw: (key, world) ->
    value = @get_local(key)
    return value if value?
    @up.get_raw(key, world or @)

  get: (key) ->
    value = @get_raw(key)
    return value(@,{}) if isFunction(value)
    value

  owner: (key) ->
    return @ if @get_local(key)?
    @up.owner(key)
    
  update: (key, delta, max) ->
    result = @get(key) + delta
    result = wraparound(result, max) if max?
    @put(key, result)

  call: (key, args) ->
    closure = @get_raw(key)
    assert isFunction(closure), "#{key}: #{closure} is not a function"
    closure(@, args)
    
  # TODO: refactor import_dict methods somewhere
  _import_children: (array) ->
    result = @rx().array()
    for value in array
      assert value, 'import child'
      result.push @make_world(value)
    result
    
  import_dict: (dict) ->
    for key, value of dict
      #console.log("import_dict #{value} for #{key}")
      value = @_from_dict(value) if (key == AUTHORITY)
      value = @_import_children(value) if key == CHILDREN
      #console.log("import_dict #{value} for #{key}")
      @put(key, value)
    this

  _spawn_world: (label) ->
    authority = @get(AUTHORITY)
    new World(authority or @, label)
    
  _from_value: (value) ->
    assert isString(value), "_from_value requires string"
    world = @_spawn_world "#{value}"
    world.put("value", value)
    world

  _from_dict: (dict) ->
    assert _.isObject(dict), "authority isn't dictionary"
    label = dict[LABEL] or "#{@get(LABEL)}:#{@_child_count()}"
    world = @_spawn_world label
    world.import_dict dict

  make_world: (value) ->
    return value if @is_world(value)
    return @_from_dict(value) if isObject(value)
    @_from_value value
    
  _children: -> @get(CHILDREN)
  _child_array: -> @_children().all()
  _child_count: -> @_children().length()
  has_children: -> @_child_count() > 0
    
  add_child: (value) ->
    child = @make_world value
    assert child, "add_child"
    assert !_.isFunction @get_raw(CHILDREN)
    @get(CHILDREN).push(child)
    child
    
  find_children: (label) ->
    return @_child_array() unless label?
    result = []
    for child in @_child_array()
      result.push child if child.label() == label
    result
    
  find_child: (label) ->
    @find_children(label)[0]

  map_children: (callback) ->
    result = @rx().array()
    index = 0
    for child in @_child_array()
      result.push callback(child, index)
      index += 1
    result
  
  label: ->
    @get(LABEL)
    
  toString: ->
    "World:#{@label()}"
    
  is_world: (obj) ->
    obj instanceof World

exports.world = (up, rx, doc) ->
  root = new World(up, "root", rx)
  root.put(RX, rx)
  root.import_dict(doc)
