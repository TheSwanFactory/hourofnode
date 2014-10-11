# Data model

class World
  constructor: (rx, doc) ->
    @doc = rx.map()
    @rx = rx
    @bind = rx.bind
    for key, value of doc
      if value instanceof Object
        value = new World(rx, value)
      @doc.put(key, value)
    
  get: (key) ->
    @doc.get(key)

  put: (key, value) ->
    @doc.put(key, value)
    
  bind: (exp) ->
    @bind exp
    
  toString: ->
    @doc

exports.god = (rx, doc) ->
  new World(rx, doc)
