assert = require 'assert'
{programs} = require('./programs')
exports.turtles = {
  _LABEL: "turtles"
  _KIND: "turtle"
  name: (world, args) -> world.label()
  stroke: "green"
  path: (world, args) -> world.get('game').kinds.turtle.paths

  _AUTHORITY: {
    _SETUP: (world, args) ->
      return if world.label().length > 2
      store = world.make_world(programs)
      store.call('load')
      world.put 'programs', store  
      world.send 'create', world
    next_signal: (world, args) ->
      local = world.get('programs')
      assert signal = local.call('next'), "No next signal"
      signal
  }
    
  _CHILDREN: [
    {
      _LABEL: "me"
      p: [1,1]
      v: [1,0]
      fill: "#88ff88"
    }
    {
      _LABEL: "EP"
      p: [3,3]
      v: [-1,0]
      fill: "#000088"
    }
  ]
}