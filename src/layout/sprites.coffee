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
  paths = shapes.get(shape).all()
  my.assert paths, "No paths for #{shape} of #{sprite_dict}"
  sprite_dict.paths = paths

combine = (a, b, dir) ->
  if dir > 0 then vector.add(a, b) else vector.subtract(a, b)

get_location_for_move = (world, dir) ->
  combine world.get_plain('position'), world.get_plain('direction'), dir

exports.sprites = {
  _LABEL: 'sprites'
  _KIND: 'sprite'
  _EXPORTS: ['inspect', 'reset']
  _SETUP: (world) ->
    shapes = world.get 'shapes'
    sprites = world.get 'sprites'
    for sprite_dict in sprites.all()
      set_shape(sprite_dict, shapes)
      child = world.add_child sprite_dict
      child.handle_event 'apply'
      world.send 'inspect', child

  # selection
  
  inspect: (world, sprite) -> world.put 'inspected', sprite
  selected: (world) -> world == world.get('inspected')
  click: (world, args) -> world.send 'inspect', world

  # defaults
  
  position:  [0,0]
  next_position: null
  direction: [1,0]
  obstruction: true

  # geometry
  
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

  # behavior

  behavior:
    first:     []
    repeat:    []
    interrupt: []

  running: 'first'
  editing: 'first'

  determine_next_position: (world, args) -> world.get('next_position') || world.get('position')

  # perform
 
  apply: (world, args) ->
   {target, action, instruction} = args
   console.log "apply #{action}: world #{world} =? target #{target}"
   world.call('perform', action) if world == target

  prepare: (world, action) ->
    console.log action
    world.call 'perform', action

  perform: (world, action) ->

    phrase = world.get('actions').get(action)
    # TODO: use actions.coffee
    # this is bad. it should be getting this from actions.coffee
    instruction = phrase.split " "
    instruction[2] = parseInt instruction[2]

    [method, key, value] = instruction
    my.assert world[method], "#{world.label()}: no '#{method}' property"
    world[method](key, value)

  commit: (world, args) ->
    world.put 'position', world.get('determine_next_position') # proposed coordinates

  # direct actions
  
  go: (world, dir) ->
    cell_count = world.get_plain('cell_count')
    my.assert dir?, "expects dir"
    sum = get_location_for_move world, dir
    world.put 'next_position', sum

  turn: (world, dir) ->
    my.assert dir?, "expects dir"
    world.put 'direction', vector.turn(world.get('direction'), dir)
    true # always a valid move

  reset: (world, args) ->
    ['position', 'direction'].map (key) -> world.put key, undefined

  step: (world, args) ->
    local = world.get('programs')
    return unless world.is_world local
    my.assert signal = local.call('next'), "No next signal"
    world.call 'perform', signal
}
