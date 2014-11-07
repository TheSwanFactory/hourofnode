assert = require 'assert'
SPRITE_EXPORTS = ["step", "reset"]

# Uses Turtle as an Authority
exports.sprites = {
  _LABEL: "sprites"
  _KIND: "sprite"
  _SETUP: (world) ->
    this_level = world.get 'current_level'
    console.log 'this_level', this_level.name
    for sprite in this_level.sprites
      world.call 'sprite', sprite
  sprite: (world, args) ->
    dict = {_LABEL: args.name, _EXPORTS: SPRITE_EXPORTS}
    child = world.add_child dict
    child.put my.key.authority, world.make_world(args)
    world.send 'programs', args.programs, (value) -> world.put 'programs', value
    world.send 'inspect', child

  p: [0, 0]
  v: [1, 0]
  i: (world) -> world.get('p').at(0)
  j: (world) -> world.get('p').at(1)
  v_i: (world) -> world.get('v').at(0)
  v_j: (world) -> world.get('v').at(1)
  name_style: (world) ->
    scale = world.get 'scale'
    {x: 0.5 * scale, y: 0.5 * scale, fill: "white", stroke: "white"}
  angle: (world) ->
    # TODO: perform real triginometry
    v = world.get('v')
    value = 90*(1 - v.at(0)) #0, 90, 180, 90, 0
    value = -90 if v.at(1) < 0
    value

  p_index: (world, args) ->
    n_cols = world.get('split')
    p = world.get('p')
    assert world.is_array(p), "is reactive array"
    p.at(1)*n_cols + p.at(0)
    
  go: (world, args) ->
    split = world.get('split')
    {dir} = args
    assert dir?, "expects dir"
    p = world.get('p')
    v = world.get('v')
    next_p = [0,1].map (i) ->
      value = p.at(i) + dir*v.at(i)
      value = 0 if value >= split
      value = (split - 1) if value < 0
      value
    world.put 'p', next_p
    
  turn: (world, args) ->
    {dir} = args
    assert dir, "expects dir"
    v = world.get('v')
    next_v_i =  dir * v.at(1)
    next_v_j = -1 * dir * v.at(0)
    world.put 'v', [next_v_i, next_v_j]
    
  perform: (world, signal) -> world.call(signal['do'], signal)
  step: (world, args) ->
    local = world.get('programs')
    return unless world.is_world local
    assert signal = local.call('next'), "No next signal"
    world.call 'perform', signal
  reset: (world, args) ->
    ['p', 'v'].map (key) -> world.put key, undefined
  click: (world, args) -> world.send 'inspect', world
}