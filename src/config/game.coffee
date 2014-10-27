exports.game = {
  _LABEL: "game"
  interval: 500
  speed: 0
  run: (world, args) ->
    step_and_repeat = (self) ->
      speed = world.get('speed')
      if speed > 0
        delay = world.get('interval') / speed 
        world.send(".turtles", "step")
        setTimeout((-> self(self)), delay)
    step_and_repeat(step_and_repeat)

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
  reset: (world, args) ->
    world.put 'program_counter', 0
    turtles = world.find_parent 'turtles'
    turtles.map_children (child) ->
      child.put 'i', child.get('i_0')
      child.put 'j', child.get('j_0')  
}