assert = require 'assert'

RX = "_RX"
LABEL = "_LABEL"
CHILDREN = "_CHILDREN"

isFunction = (value) ->
  typeof(value) == "function"

isObject = (value) ->
  typeof(value) == "object"

isString = (value) ->
  typeof(value) == "string"

class World
  constructor: (up, label, rx) ->
    assert up, "up always exists"
    @up = up
    cache_rx = rx or @up.get(RX)
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

  get_raw: (key, world=this) ->
    @get_local(key) or @up.get_raw(key, this)

  get: (key) ->
    value = @get_raw(key)
    return value(this,{}) if isFunction(value)
    value
    
  update: (key, delta) ->
    @put(key, @get(key) + delta)

  call: (key, args) ->
    closure = @get_raw(key)
    assert isFunction(closure), "#{key} is function"
    closure(this, args)
    
  import_dict: (dict) ->
    for key, value of dict
      if key == CHILDREN
        for child in value
          assert child, 'import child'
          @add_child child
      else
        @put(key, value)
    this

  world_from_value: (value) ->
    assert isString(value), "world_from_value requires string"
    label = "#{value}"
    world = new World(@, label)
    world.put("value", value)
    world

  world_from_dict: (dict) ->
    label = dict[LABEL] || "#{@get(LABEL)}:#{@get(CHILDREN).length}"
    world = new World(@, label)
    world.import_dict(dict)

  make_world: (value) ->
    return value if @is_world(value)
    return @world_from_dict(value) if isObject(value)
    @world_from_value(value)
    
  add_child: (value) ->
    child = @make_world(value)
    assert child, "add_child"
    @get(CHILDREN).push(child)
    child

  has_children: ->
    @get(CHILDREN).length() > 0
    
  map_children: (callback) ->
    @get(CHILDREN).map callback
    
  toString: ->
    "World:#{@get(LABEL)}"
    
  is_world: (obj) ->
    obj instanceof World

exports.world = (up, rx, doc) ->
  root = new World(up, "root", rx)
  root.put(RX, rx)
  root.import_dict(doc)
