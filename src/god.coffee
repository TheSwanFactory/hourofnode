# Data model
isFunction = (value) ->
  typeof(value) == "function"
  
normalize_value = (rx, value) ->
  if isFunction(value)
    value
  else if value instanceof Object
    value = new World(rx, value)
  else
    value

class World
  constructor: (rx, doc) ->
    @doc = rx.map()
    @rx = rx
    @bind = rx.bind
    for key, value of doc
      value = normalize_value(rx, value)
      @doc.put(key, value)
    
  map: (callback) ->
    console.log Object.keys(@doc.x)
    result = []
    for key in Object.keys(@doc.x)
      value = @get_raw(key)
      result += callback(key, value)
    console.log result
    result
    
  get_raw: (key) ->
    @doc.get(key)

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
    @bind exp
    
  toString: ->
    @doc

exports.god = (rx, doc) ->
  new World(rx, doc)
