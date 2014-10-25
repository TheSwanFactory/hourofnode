assert = require 'assert'

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
  "m#{-3*scale},0 a3,2 0 1,0 #{6*scale},0 
   m0,0           a3,2 0 1,0 #{-6*scale},0z"

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
  go: (world, args) ->
    split = world.get('split')
    {dir} = args
    assert dir, "expects dir"
    world.update 'i', dir * world.get('v_i'), split
    world.update 'j', dir * world.get('v_j'), split
  turn: (world, args) ->
    {dir} = args
    assert dir, "expects dir"
    next_v_i =  dir * world.get('v_j')
    next_v_j = -1 * dir * world.get('v_i')
    world.put 'v_i', next_v_i
    world.put 'v_j', next_v_j
    
  program: []
  program_counter: 0
  prog: (world, args) ->
    {signal} = args
    program = world.get('program')
    program.push signal
    console.log "prog: #{world}", world, args, signal, program
  reload_program:  (world, args) ->
    {name} = args
    loader= world.find '.controls.program_loader'
    context = loader.find_child(name)
    program = context.call('program')
    console.log "reload_program #{name}", program
    assert program
    world.put 'program', program 
    program
  step: (world, args) ->
    turtles = world.find_parent 'turtles'
    counter = world.get('program_counter')
    program = world.get('program')
    if counter >= program.length()
      program = world.call('reload_program', {name: 'default'})
      counter = 1
    assert signal = program.at(counter), "No signal"
    assert action = world.get('signals')[signal], "No action"
    turtles.map_children (child) -> child.call(action['do'], action)
    world.put('program_counter', counter + 1)
  interval: 500
  speed: 0
  run: (world, args) ->
    step = world.get_raw('step')
    {speed} = args
    assert _.isFunction(step), "step is not a function"
    assert speed?, "run: requires speed"
    world.owner('speed').put('speed', speed)
    step_and_repeat = (self) ->
      speed = world.get('speed')
      if speed > 0
        delay = world.get('interval') / speed 
        step(world, args)
        setTimeout((-> self(self)), delay)
    step_and_repeat(step_and_repeat)
  reset: (world, args) ->
    world.put 'program_counter', 0
    turtles = world.find_parent 'turtles'
    turtles.map_children (child) ->
      child.put 'i', child.get('i_0')
      child.put 'j', child.get('j_0')
  
  _AUTHORITY: {
    path: (world, args) -> 
      scale = world.get('scale') / 10
      [draw_legs(scale) + draw_face(scale), draw_shell(scale)]
    click: (world, args) ->
      owner = world.owner('current')
      owner.put('current', world)
  }
  _CHILDREN: [
    {
      _LABEL: "me"
      i_0: 4.5
      j_0: 4.5
      i: 4.5
      j: 4.5
      v_i: 0
      v_j: 1
      fill: "#88ff88"
    }
    {
      _LABEL: "yu"
      i_0: 1.5
      j_0: 3.5
      i: 1.5
      j: 3.5
      fill: "#008800"
    }
    {
      _LABEL: "EP"
      i_0: 2.5
      j_0: 3.5
      i: 2.5
      j: 3.5
      fill: "#880000"
    }
    {
      _LABEL: "AW"
      i_0: 5.5
      j_0: 0.5
      i: 5.5
      j: 0.5
      fill: "#000088"
    }
  ]
}