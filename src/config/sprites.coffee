assert = require 'assert'
SPRITE_EXPORTS = ["step", "reset"]

# Uses Turtle as an Authority
exports.sprites = {
  _LABEL: "sprites"
  NewFromTurtle: (world, args) ->
    world.authority = args
    dict = {_LABEL: args.label(), _EXPORTS: SPRITE_EXPORTS}
    child = world.add_child dict

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
    action = world.get('next_action')
    console.log 'step', action
    world.call(action['do'], action)
  reset: (world, args) ->
    world.put 'program_counter', 0
    for key in ['i', 'j', 'v_i', 'v_j']
      world.put key, undefined
  click: (world, args) ->
    owner = world.owner('current')
    owner.put('current', world)
}