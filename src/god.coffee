{world} = require('./world')
  
class GOD
  get_raw: (key, world) ->
    console.log "key '#{key}' not found: #{world}"
    undefined
  owner: (key) ->
    undefined
  toString: ->
    "GOD"
    
exports.god = (rx, doc) ->
  god = new GOD()
  root = world(god, rx, doc)
  root
