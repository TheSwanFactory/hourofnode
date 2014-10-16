{world} = require('./world')

# Data model
isFunction = (value) ->
  typeof(value) == "function"
  
class GOD
  constructor: (@rx) ->
  get_raw: (key, world) ->
    return @rx if key == "_rx"
    console.log "key '#{key}' not found: #{world}"
    undefined
  toString: ->
    "GOD"
    
exports.god = (rx, doc) ->
  god = new GOD(rx)
  root = world("root", god)
  root.put("_rx", rx)
  root.import(doc)
  root
