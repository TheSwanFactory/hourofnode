assert = require 'assert'
SPRITE_EXPORTS = ["step", "reset"]

# Uses Turtle as an Authority
exports.sprites = {
  _LABEL: "sprites"
  _KIND: "sprite"
  _EXPORTS: ['create']
  create: (world, args) ->
    world.authority = args
    dict = {_LABEL: args.label(), _EXPORTS: SPRITE_EXPORTS}
    child = world.add_child dict
    world.send 'created', child
  go: (world, args) ->
    split = world.get('split')
    {dir} = args
    assert dir, "expects dir"
    world.update 'i', dir * world.get('v_i'), split
    world.update 'j', dir * world.get('v_j'), split
  turn: (world, args) ->
    {dir} = args
    assert dir, "expects dir"
    v = world.get('v')
    next_v_i =  dir * v.at(1)
    next_v_j = -1 * dir * v.at(0)
    v.put 0, next_v_i
    v.put 1, next_v_j
  step: (world, args) ->
    signal = world.get('next_signal')
    world.call(signal['do'], signal)
  reset: (world, args) ->
    # TODO: Reset program counter
    for key in ['i', 'j', 'v_i', 'v_j']
      world.put key, undefined
  click: (world, args) ->
    world.send('inspect', world)
}