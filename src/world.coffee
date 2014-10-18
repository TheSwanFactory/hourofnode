assert = require 'assert'

RX = "_RX"
LABEL = "_LABEL"
CHILDREN = "_CHILDREN"

isFunction = (value) ->
  typeof(value) == "function"

class World
  constructor: (up, label, rx) ->
    @up = up
    cache_rx = rx or @up.get(RX)
    assert cache_rx, "cache_rx"
    @doc = cache_rx.map()
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
    if isFunction(value)
      return value(this,{})
    value
    
  update: (key, delta) ->
    @put(key, @get(key) + delta)

  call: (key, args) ->
    closure = @get_raw(key)
    closure(this, args)
    
  import_dict: (dict) ->
    console.log 'import_dict'
    console.log dict
    for key, value of dict
      if key == CHILDREN
        for child in value
          @add_child child
      else
        @put(key, value)
    this

  world_from_value: (value) ->
    assert value, "world_from_value"
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
    return @world_from_dict(value) if typeof(value) == "object"
    @world_from_value(value)
    
  add_child: (value) ->
    console.log "add_child value"
    console.log value
    child = @make_world(value)
    assert child, "add_child"
    @get(CHILDREN).push(child)
    child

  has_children: ->
    @get(CHILDREN).length() > 0
    
  map_children: (callback) ->
    console.log(@)
    result = []
    for child in @get(CHILDREN)
      assert child, "child in #{@get(CHILDREN)}"
      result.push callback(child)
    result

  toString: ->
    "World:#{@get(LABEL)}"
    
  is_world: (obj) ->
    obj instanceof World

exports.world = (up, rx, doc) ->
  root = new World(up, "root", rx)
  root.put(RX, rx)
  root.import_dict(doc)
