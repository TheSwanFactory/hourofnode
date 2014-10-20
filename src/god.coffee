{world} = require('./world')
  
class GOD
  debug: false
  get_raw: (key, world) ->
    return @debug if key == "debug"
    console.log "key '#{key}' not found: #{world}" if @debug
    undefined
  owner: (key) ->
    undefined
  toString: ->
    "GOD"
    
exports.god = (rx, doc) ->
  god = new GOD()
  root = world(god, rx, doc)
  root
