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

combine = (a, b, dir) ->
  if dir > 0 then vector.add(a, b) else vector.subtract(a, b)

get_location_for_move = (world, dir) ->
  combine world.get_plain('position'), world.get_plain('direction'), dir

exports.sprites = {
  _LABEL: 'sprites'
  _KIND: 'sprite'
  _EXPORTS: ['make_sprite']
  make_sprite: (world, sprite_dict) ->
    child = world.add_child sprite_dict
    child.put 'dict', sprite_dict
    child.handle_event 'reset'
    child.handle_event 'inspect'
    child.put my.key.authority, world.make_world sprite_dict.authority
    #child.call 'reset'
    world.send 'inspect', child

  # selection
  
  inspect: (world, sprite) -> world.put 'inspected', sprite
  selected: (world) -> world == world.get 'inspected'
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

  # behavior defaults

  running: 'first'
  editing: 'first'

  proposed_position: (world, args) ->
    world.get('next_position') || world.get('position')
  
  load_program: (world, key) ->
    # TODO: reset program counter somewhere
    world.put 'running', key
  
  collision: (world, obstruction) ->
    key = 'interrupt' # TODO: make inheritable
    world.call 'load_program', key

  commit: (world, args) ->
    world.put 'position', world.get('proposed_position') 

  # direct actions (instructions)
  
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
    dict = world.get 'dict'
    kind = world.get my.key.authority
    ['position', 'direction'].map (key) ->
      value = dict[key] or kind.get key
      world.put key, value
}
