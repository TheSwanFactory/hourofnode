{world} = require('./world')

# Data model
isFunction = (value) ->
  typeof(value) == "function"
  
class GOD
  get_raw: (key, world) ->
    console.log "key '#{key}' not found: #{world}"
    undefined
  toString: ->
    "GOD"
    
exports.god = (rx, doc) ->
  god = new GOD()
  root = world("root", god)
  root.put("_rx", rx)
  root.import(doc)
  root
