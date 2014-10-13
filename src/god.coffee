# Data model
normalize_value = (value) ->
  if typeof(value) == "function"
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
      value = normalize_value(value)
      @doc.put(key, value)
    
  get: (key) ->
    @doc.get(key)

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
