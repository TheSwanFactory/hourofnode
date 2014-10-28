{world} = require('./world')
  
class GOD
  debug: false
  get_raw: (key, world) ->
    return @debug if key == "debug"
    return world.up if key == "up"
    console.log "key '#{key}' not found: #{world}" if @debug
    undefined
  label: -> "GOD"
  toString: -> @label()
    
exports.god = (rx, doc) ->
  god = new GOD()
  root = world(god, rx, doc)
  root
