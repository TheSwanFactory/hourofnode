{world} = require './god/world'
{events} = require './god/events'
  
class GOD
  debug: false
  get_raw: (key, world) ->
    return @debug if key == "debug"
    return world.up if key == "up"
    console.log "key '#{key}' not found: #{world.label()}" if @debug
    undefined
  get_raw_plain: (key, world) ->
    @get_raw(key, world)
  label: -> "GOD"
  toString: -> @label()
    
exports.god = (rx, doc) ->
  god = new GOD()
  root = world(god, rx, doc)
  root.put 'events', root.make_world(events)
  root
