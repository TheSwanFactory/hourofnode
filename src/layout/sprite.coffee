#
# sprite.coffee
#
# Role: Draw and control objects that live in the grid
#
# Responsibility: 
# * create sprites from game description
# * associate with a path
# * associate with a state representation

{my} = require '../my'
{vector} = require('../god/vector')
{sprite_state} = require './sprite_state'

exports.sprite = {
  _LABEL: "sprite"
  _KIND: "sprite"
  _EXPORTS: ["step", "reset"]
  _SETUP: (world) ->
    shapes = world.get 'shapes'
    sprites = world.get 'sprites'
    console.log 'sprite _SETUP', world, shapes, sprites
    for sprite in sprites.all()
      console.log 'sprite', sprite, paths
      paths = shapes[sprite.shape]
      my.assert paths, "No paths for #{sprite.shape} of #{sprite}"
      # sprite.put 'paths', paths 
      # world.call 'sprite', sprite
  sprite: (world, sprite) ->
    sprite.put 'state', sprite_state(sprite)
    world.add_child sprite
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