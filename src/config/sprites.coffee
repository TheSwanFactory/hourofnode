assert = require 'assert'

# Uses Turtle as an Authority
exports.sprites = {
  _LABEL: "sprites"
  from_turtle: (world, args) ->
    
  _AUTHORITY = {
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
    step: (world, args) ->
      counter = world.get('program_counter')
      program = world.get('program')
      if counter >= program.length()
        program = world.call('reload_program', {name: 'default'})
        counter = 1
      assert signal = program.at(counter), "No signal"
      assert action = world.get('signals')[signal], "No action"
      world.call(action['do'], action)
      world.put('program_counter', counter + 1)
    reset: (world, args) ->
      world.put 'program_counter', 0
      world.put 'i', world.get('i_0')
      world.put 'j', world.get('j_0')
    _EXPORTS: ["step", "reset"]
  }

}