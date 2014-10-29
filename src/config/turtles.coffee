assert = require 'assert'

draw_leg = (scale, offset, dir) ->
  arc = if dir < 1 then 0 else 1
  "M#{offset*scale},0 l#{scale},#{dir*3*scale}
   a1,2 0 1,#{arc} #{-1*scale},#{-1*dir*3*scale}z m#{-offset*scale},0"
  
draw_legs = (scale) ->
  draw_leg(scale, 1, -1) + draw_leg(scale, 1, 1) + 
  draw_leg(scale, -1, -1) + draw_leg(scale, -1, 1)

draw_face = (scale) ->
  "M#{2.5*scale},0 
   a3,2 0 0,0 #{2*scale},0 
   a3,2 0 0,0 #{-2*scale},0 
   z m#{-3.5*scale},0"

draw_shell = (scale) ->
  "M#{-3*scale},0 a3,2 0 1,0 #{6*scale},0 
                  a3,2 0 1,0 #{-6*scale},0z"

exports.turtles = {
  _LABEL: "turtles"
  name: (world, args) -> world.label()
  stroke: "green"
  selected: (world) -> world == world.get('current')
  v_i: 1
  v_j: 0
  angle: (world, args) ->
    # TODO: perform real triginometry
    v_i = world.get('v_i')
    v_j = world.get('v_j')
    value = 90*(1-v_i) #0, 90, 180, 90, 0
    value = -90 if world.get('v_j') < 0
    value
    
  program: []
  program_counter: 0
  prog: (world, args) ->
    {signal} = args
    program = world.get('program')
    program.push signal
    console.log "prog: #{world}", world, args, signal, program
  reload_program:  (world, args) ->
    {name} = args
    loader= world.find_path '.inspector.program_loader'
    context = loader.find_child(name)
    program = context.call('program')
    console.log "reload_program #{name}", program
    assert program
    world.put 'program', program 
    program
  path: (world, args) -> 
    scale = world.get('scale') / 10
    [draw_legs(scale) + draw_face(scale), draw_shell(scale)]
  _CHILDREN: [
    {
      _LABEL: "me"
      i: 4.5
      j: 4.5
      v_i: 0
      v_j: 1
      fill: "#88ff88"
    }
    {
      _LABEL: "yu"
      i: 1.5
      j: 3.5
      fill: "#008800"
    }
    {
      _LABEL: "EP"
      i: 2.5
      j: 3.5
      fill: "#880000"
    }
    {
      _LABEL: "AW"
      i: 5.5
      j: 0.5
      fill: "#000088"
    }
  ]
}