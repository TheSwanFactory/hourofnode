# Data model

class World
  constructor: (rx, doc) ->
    @doc = rx.cell(doc)
    
  get: (path) ->
    "not implemented yet"

  set: (path, value) ->
    "not implemented yet"

exports.god = (rx, doc) ->
  new World(rx, doc)
