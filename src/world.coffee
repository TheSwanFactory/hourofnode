RX = "_RX"
CHILDREN = "_CHILDREN"

# Data model
isFunction = (value) ->
  typeof(value) == "function"

class World
  constructor: (@label, @up, @rx) ->
    @rx = @up.get(RX) unless @rx?
    @doc = @rx.map()
    @doc.put(CHILDREN, [])

  put: (key, value) ->
    @doc.put(key, value)

  get_local: (key) ->
    @doc.get(key)

  get_raw: (key, world=this) ->
    value = @get_local(key)
    if value? then value else @up.get_raw(key, this)

  get: (key) ->
    value = @get_raw(key)
    if isFunction(value)
      return value(this,{})
    value
    
  add_child: (value) ->
    @get(CHILDREN).push(value)

  map_child: (callback) ->
    result = []
    for value in @get(CHILDREN)
      result.push callback(value)
    result

  reset: (key, delta) ->
    @put(key, @get(key) + delta)

  call: (key, args) ->
    closure = @get_raw(key)
    closure(this, args)
    
  bind: (exp) ->
    @rx.bind exp

  toString: ->
    "World:#{@label}"

exports.world = (up, rx, doc) ->
  root = new World("root", up, rx)
  root.put(RX, rx)
  for key, value of doc
    root.put(key, value)
  root
