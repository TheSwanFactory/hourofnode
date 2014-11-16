{my} = require '../my'
{vector} = require('../god/vector')
{sprite_state} = require './sprite_state'

exports.sprites = {
  _LABEL: "sprites"
  _KIND: "sprite"
  _EXPORTS = ["step", "reset"]
  _SETUP: (world) ->
    paths = world.get 'paths'
    sprites = world.get 'sprites'
    sprites.map (sprite) ->
      sprite.paths = paths[sprite.kind]
      my.assert paths, "No paths for #{sprite.kind} of #{sprite}"
      world.call 'sprite', sprite
  sprite: (world, args) ->
    sprite.state = sprite_state(sprite)
    world.send 'inspect', child
    
  name_style: (world) ->
    scale = world.get 'scale'
    {x: 0.5 * scale, y: 0.5 * scale, fill: "white", stroke: "white"}
  angle: (world) -> vector.angle world.get('v')

  p_index: (world, args) ->
    n_cols = world.get('split')
    p = world.get('p')
    my.assert world.is_array(p), "is reactive array"
    p.at(1)*n_cols + p.at(0)
        
  go: (world, args) ->
    split = world.get('split')
    {dir} = args
    my.assert dir?, "expects dir"
    p = world.get('p')
    v = world.get('v')
    sum = vector.add(p, v)
    result = vector.bound sum, split, -> world.send 'error'
    world.put 'p', result 

  turn: (world, args) ->
    {dir} = args
    my.assert dir, "expects dir"
    world.put 'v', vector.turn(world.get('v'), dir)
    
  perform: (world, signal) -> world.call(signal['do'], signal)
  step: (world, args) ->
    local = world.get('programs')
    return unless world.is_world local
    my.assert signal = local.call('next'), "No next signal"
    world.call 'perform', signal
  reset: (world, args) ->
    ['p', 'v'].map (key) -> world.put key, undefined
  click: (world, args) -> world.send 'inspect', world
}