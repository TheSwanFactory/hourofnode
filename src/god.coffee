{world} = require './god/world'
  
class GOD
  debug: false
  get_raw: (key, world) ->
    return @debug if key == "debug"
    return world.up if key == "up"
    console.warn "key '#{key}' not found: #{world.label()}" if @debug
    undefined
  label: -> "GOD"
  toString: -> @label()
    
exports.god = (rx, doc) ->
  god = new GOD()
  root = world(god, rx, doc)
  root
