#
# sprites.coffee
#
# Role: Draw and control objects that live in the grid
#
# Responsibility: 
# * create sprites from game description
# * associate with a path and state representation
# * define actions the sprite can perform

{my} = require '../my'
{vector} = require('../god/vector')

transform = (world) ->
  center = world.get('cell_size') / 2
  translate = "translate(#{world.get('x') || 0},#{world.get('y') || 0})"
  rotate = world.get('angle') && center? && "rotate(#{world.get('angle')} #{center} #{center})"
  "#{translate} #{rotate || ''}"

cell_position = (world, axis) ->
  cell_size = world.get 'cell_size'
  position = world.get 'position'
  cell_size * position.at(axis)

set_shape = (sprite_dict, shapes) ->
  shape = sprite_dict.shape
  paths = shapes[shape]
  my.assert paths, "No paths for #{shape} of #{sprite_dict}"
  sprite_dict.paths = paths
  
combine = (a, b, dir) ->
  if dir > 0 then vector.add a, b else vector.subtract a, b
  

exports.sprites = {
  _LABEL: 'sprites'
  _KIND: 'sprite'
  _EXPORTS: ['inspect', 'step', 'reset']
  _SETUP: (world) ->
    shapes = world.get 'shapes'
    sprites = world.get 'sprites'
    for sprite_dict in sprites.all()
      set_shape(sprite_dict, shapes)
      child = world.add_child sprite_dict
      child.handle_event 'apply'
      # world.send 'inspect', child
  inspect: (world, sprite) -> world.put 'inspected', sprite
  selected: (world) -> world == world.get('inspected')

  # defaults
  position:  [0,0]
  direction: [1,0]
  x: (world) -> cell_position(world, vector.axis.x)
  y: (world) -> cell_position(world, vector.axis.y)
  angle: (world) -> vector.angle world.get('direction')
  transform: (world) ->
    my.assert center = world.get('cell_size') / 2
    translate = "translate(#{world.get('x')},#{world.get('y')})"
    rotate = "rotate(#{world.get('angle')} #{center} #{center})"
    "#{translate} #{rotate}"

  name_style: (world) ->
    cell_size = world.get 'cell_size'
    {x: 0.5 * cell_size, y: 0.5 * cell_size, fill: "white", stroke: "white"}

  # TODO: Make less order-dependent
  
  propose: (world, proposal) ->
    others = world.send 'at_position', proposal
    results = obstacles.map (others) -> others.call 'bumps', world
    world.put 'position', proposal unless results
    
  go: (world, dir) ->
    cell_count = world.get('cell_count')
    my.assert dir?, "expects dir"
    sum = combine(world.get 'position', world.get 'direction', dir)
    if vector.inside(sum, cell_count)
      world.call 'propose', sum
    else
      world.send 'error', "#{world} attempted to move out of bounds"

  turn: (world, dir) ->
    my.assert dir?, "expects dir"
    world.put 'direction', vector.turn(world.get('direction'), dir)
    true # always a valid move
  
  perform: (world, action) ->
    [method, key, value] = action
    my.assert world[method], "#{world.label()}: no '#{method}' property"
    world[method](key, value)
    
  apply: (world, args) ->
    {target, action} = args
#    console.log "apply world #{world}, target #{target}"
    world.call('perform', action) if world == target
    
  step: (world, args) ->
    local = world.get('programs')
    return unless world.is_world local
    my.assert signal = local.call('next'), "No next signal"
    world.call 'perform', signal
  reset: (world, args) ->
    ['position', 'direction'].map (key) -> world.put key, undefined
  click: (world, args) -> world.send 'inspect', world
}