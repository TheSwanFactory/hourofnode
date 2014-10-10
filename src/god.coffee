# Data model

class World
  constructor: (rx, doc) ->
    @doc = rx.map()
    for key, value of doc
      @doc.put(key, value)
    
  get: (key) ->
    @doc.get(key)

  put: (key, value) ->
    @doc.put(key, value)
    
  toString: ->
    @doc

exports.god = (rx, doc) ->
  new World(rx, doc)
