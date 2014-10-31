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
    p = world.get('p')
    v = world.get('v')
    next_p = [0,1].map (i) -> (p.at(i) + dir*v.at(i)) % split
    world.put 'p', next_p
    
  turn: (world, args) ->
    {dir} = args
    assert dir, "expects dir"
    v = world.get('v')
    next_v_i =  dir * v.at(1)
    next_v_j = -1 * dir * v.at(0)
    world.put 'v', [next_v_i, next_v_j]
    
  step: (world, args) ->
    #console.log "+step", world.get('p').all(), world.get('v').all(), 
    signal = world.get('next_signal')
    world.call(signal['do'], signal)
  reset: (world, args) ->
    for key in ['p', 'v']
      world.put key, undefined
  click: (world, args) ->
    world.send('inspect', world)
}