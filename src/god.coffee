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
    
  get: (key) ->
    @doc.get(key)

  get_value: (key) ->
    value = @doc.get(key)
    value

  put: (key, value) ->
    @doc.put(key, value)

  call: (key, args) ->
    closure = @doc.get(key)
    closure(this, args)
    
  bind: (exp) ->
    @bind exp
    
  toString: ->
    @doc

exports.god = (rx, doc) ->
  new World(rx, doc)
