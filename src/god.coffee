# Data model
isFunction = (value) ->
  typeof(value) == "function"
  

class World
  constructor: (rx, label, doc, up) ->
    @rx = rx
    @doc = rx.map()
    @label = label
    @up = up
    for key, value of doc
      if value instanceof Object && !isFunction(value)
        value = new World(rx, key, value, this)
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

  put: (key, value) ->
    @doc.put(key, value)

  call: (key, args) ->
    closure = @get_raw(key)
    closure(this, args)
    
  bind: (exp) ->
    @rx.bind exp

  map: (callback) ->
    result = []
    for key in Object.keys(@doc.x)
      value = @get_raw(key)
      result.push callback(key, value)
    result

  toString: ->
    "World:#{@label}"
    
class Root
  get_raw: (key, world) ->
    console.log "#{key} not found"
    console.log world
  toString: ->
    "Root"
    
exports.god = (rx, doc) ->
  root = new Root()
  new World(rx, "world", doc, root)
