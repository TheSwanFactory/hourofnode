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

  program_store: {
    default: ["forward"]
  }

  prog: (world, args) ->
    {signal} = args
    program = world.get('program')
    program.push signal
    console.log "prog: #{world}", world, args, signal, program
    
  restart_program: (world, args) ->
    args = {name: 'default'} unless args?
    {name} = args
    store = world.get('program_store')
    program = store[name]
    console.log "restart_program", store, program
    assert program, "load_program: #{name} missing"
    world.put('program', program)
    world.put('program_counter', 0)
    world.call('next_action', args)
     
  next_action: (world, args) ->
    program = world.get('program')
    counter = world.get('program_counter')
    console.log "next_action:", program, counter
    signal = program.at(counter) if program? and counter?
    return world.call('restart_program', args) unless signal? or args?
    assert action = world.get('signals')[signal], "No action"
    world.put('program_counter', counter + 1)
    action
    
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