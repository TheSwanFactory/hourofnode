RX = "_RX"
LABEL = "_LABEL"
CHILDREN = "_CHILDREN"

isFunction = (value) ->
  typeof(value) == "function"

class World
  constructor: (up, label, rx) ->
    @up = up
    cache_rx = rx or @up.get(RX)
    @doc = cache_rx.map()
    @doc.put(LABEL, label)
    @doc.put(CHILDREN, [])
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
    value = @get_local(key) or @up.get_raw(key, this)

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
    for key, value of dict
      if key == CHILDREN
        for child in value
          @add_child child
      else
        @put(key, value)
    this

  world_from_value: (value) ->
    label = "#{value}"
    world = new World(@, label)
    world.put("value", value)
    world

  world_from_dict: (dict) ->
    label = dict[LABEL] || "#{@get(LABEL)}:#{@get(CHILDREN).length}"
    world = new World(@, label)
    world.import_dict(dict)

  make_world: (value) ->
    return value if typeof(value) == "World"
    return @world_from_dict(value) if typeof(value) == "object"
    @world_from_value(value)
    
  add_child: (value) ->
    child = @make_world(value)
    @get(CHILDREN).push(child)
    child

  map_child: (callback) ->
    result = []
    for value in @get(CHILDREN)
      result.push callback(value)
    result

  toString: ->
    "World:#{@get(LABEL)}"
    
  is_world: (obj) ->
    obj instanceof World

exports.world = (up, rx, doc) ->
  root = new World(up, "root", rx)
  root.put(RX, rx)
  root.import_dict(doc)
