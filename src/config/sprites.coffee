assert = require 'assert'

# Uses Turtle as an Authority
exports.sprites = {
  _LABEL: "sprites"
  NewFromTurtle: (world, args) ->
    #console.log "NewFromTurtle: #{world} #{args} #{args.get('path')}"
    _EXPORTS = ["step", "reset"]
    world.authority = args
    world.add_child "sprite #{args.label()}"
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
    for key in ['i', 'j', 'v_i', 'v_j']
      world.put key, undefined
  click: (world, args) ->
    owner = world.owner('current')
    owner.put('current', world)
}