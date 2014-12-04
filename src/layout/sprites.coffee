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

get_kind_authority = (sprite_dict, kinds) ->
  kind = sprite_dict.kind
  return unless kind
  authority = kinds.get(kind)
  my.assert authority, "No kind #{kind} for #{sprite_dict}"
  authority
  # TODO: cache world-ified kinds instead of creating one for each sprite

cell_position = (world, axis) ->
  cell_size = world.get 'cell_size'
  position = world.get 'position'
  cell_size * position.at(axis)

combine = (a, b, dir) ->
  if dir > 0 then vector.add(a, b) else vector.subtract(a, b)

get_location_for_move = (world, dir) ->
  combine world.get('position'), world.get('direction'), dir

exports.sprites = {
  _LABEL: 'sprites'
  _KIND: 'sprite'
  _EXPORTS: ['make_sprite']
  make_sprite: (world, sprite_dict) ->
    kind_authority = get_kind_authority sprite_dict, world.get('kinds')
    console.log 'makes', kind_authority, sprite_dict
    dict = $.extend true, {}, kind_authority, sprite_dict
    child = world.add_child dict
    child.put 'dict', dict
    child.handle_event 'reset'
    child.handle_event 'inspect'
    child.put my.key.authority, world.make_world kind_authority
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

  running: 'run'
  editing: 'run'

  proposed_position: (world, args) ->
    world.get('next_position') || world.get('position')

  collision: (world, obstruction) ->
    world.put 'next_position', null
    world.put 'interrupt', obstruction.labels()

  commit: (world, args) ->
    return unless world.get 'next_position'
    world.put 'position', world.get('proposed_position')
    # TODO: drop a colored sprite to mark trail
    world.put('next_position', null)

  # direct actions (instructions)

  go: (world, dir) ->
    cell_count = world.get('cell_count')
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
