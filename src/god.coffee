{world} = require('./world')
  
class GOD
  get_raw: (key, world) ->
    console.log "key '#{key}' not found: #{world.get('_LABEL')}"
    console.log world
    undefined
  toString: ->
    "GOD"
    
exports.god = (rx, doc) ->
  god = new GOD()
  root = world(god, rx, doc)
  root
