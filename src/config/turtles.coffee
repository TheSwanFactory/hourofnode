assert = require 'assert'
{programs} = require('./programs')

draw_leg = (scale, offset, dir) ->
  arc = if dir < 1 then 0 else 1
  "m#{offset*scale},0 l#{scale},#{dir*3*scale}
   a1,2 0 1,#{arc} #{-1*scale},#{-1*dir*3*scale}z m#{-offset*scale},0"
  
draw_legs = (scale) ->
  draw_leg(scale, 1, -1) + draw_leg(scale, 1, 1) + 
  draw_leg(scale, -1, -1) + draw_leg(scale, -1, 1)

draw_face = (scale) ->
  "m#{2.5*scale},0 
   a3,2 0 0,0 #{2*scale},0 
   a3,2 0 0,0 #{-2*scale},0 
   z m#{-3.5*scale},0"

draw_shell = (scale) ->
  "m#{-2*scale},0 a3,2 0 1,0 #{6*scale},0 
                  a3,2 0 1,0 #{-6*scale},0z"

exports.turtles = {
  _LABEL: "turtles"
  _KIND: "turtle"
  name: (world, args) -> world.label()
  v_i: 1
  v_j: 0
  angle: (world, args) ->
    # TODO: perform real triginometry
    v_i = world.get('v_i')
    v_j = world.get('v_j')
    value = 90*(1-v_i) #0, 90, 180, 90, 0
    value = -90 if world.get('v_j') < 0
    value
  stroke: "green"
  selected: (world) -> world == world.get('current')
  path: (world, args) -> 
    scale = world.get('scale') / 10
    [draw_legs(scale) + draw_face(scale), draw_shell(scale)]
  _AUTHORITY: {
    _SETUP: (world, args) ->
      return if world.label().length > 2
      console.log "Call setup for #{world}",world
      world.put 'programs', world.make_world(programs)
      world.send 'create', world
      world.send 'inspect', world
    next_signal: (world, args) ->
      local = world.get('programs')
      assert signal = local.call('next'), "No next signal"
      signal
  }
    
  _CHILDREN: [
    {
      _LABEL: "me"
      i: 1.5
      j: 1.5
      v_i: 1
      v_j: 0
      fill: "#88ff88"
    }
    {
      _LABEL: "yu"
      i: 1.5
      j: 3.5
      v_i: 0
      v_j: 1
      fill: "#008800"
    }
    {
      _LABEL: "EP"
      i: 3.5
      j: 1.5
      v_i: 0
      v_j: -1
      fill: "#880000"
    }
    {
      _LABEL: "AW"
      i: 3.5
      j: 3.5
      v_i: -1
      v_j: 0
      fill: "#000088"
    }
  ]
}