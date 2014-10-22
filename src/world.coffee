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
  import_dict: (dict) ->
    for key, value of dict
      if key == AUTHORITY
        assert _.isObject(value), "authority isn't dictionary"
        authority = @_from_dict(value)
        @put(AUTHORITY, authority)
      else if key == CHILDREN
        for child in value
          assert child, 'import child'
          @add_child child
      else
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
    label = dict[LABEL] or "#{@get(LABEL)}:#{@get(CHILDREN).length()}"
    world = @_spawn_world label
    world.import_dict dict

  make_world: (value) ->
    return value if @is_world(value)
    return @_from_dict(value) if isObject(value)
    @_from_value value
    
  add_child: (value) ->
    child = @make_world value
    assert child, "add_child"
    @get(CHILDREN).push(child)
    child
    
  find_children: (label) ->
    return @get(CHILDREN).all() unless label?
    result = []
    for child in @get(CHILDREN).all()
      result.push child if child.label() == label
    result
    
  find_child: (label) ->
    @find_children(label)[0]

  has_children: ->
    @get(CHILDREN).length() > 0
    
  map_children: (callback) ->
    result = @rx().array()
    for child in @get(CHILDREN).all()
      result.push callback(child)
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
