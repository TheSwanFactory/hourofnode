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
      value = normalize_value(key, value)
      @doc.put(key, value)
    
  normalize_value = (key, value) ->
    if isFunction(value)
      value
    else if value instanceof Object
      value = new World(@rx, key, value, this)
    else
      value
    
  get_local: (key, world) ->
    @doc.get(key)

  get_raw: (key) ->
    @get_local(key, this) or @up.get_local(key, this)

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
    console.log result
    result

  toString: ->
    @doc.toString()
    
class Root
  get_local: (key, world) ->
    console.log "#{key} not found"
    console.log world
  
exports.god = (rx, doc) ->
  root = new Root()
  new World(rx, "world", doc, root)
