#
# sprites.coffee
#
# Role: Draw and control objects that live in the grid
#
# Responsibility:
# * create sprites from game description
# * associate with a path and state representation
# * define actions the sprite can perform

{my}        = require '../my'
{vector}    = require '../god/vector'
{utils}     = require '../utils'

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
  _EXPORTS: ['make_sprite', 'delete_sprite']
  make_sprite: (world, sprite_dict) ->
    kind_authority = get_kind_authority sprite_dict, world.get('kinds')
    console.log 'makes', kind_authority, sprite_dict
    dict = $.extend true, {}, kind_authority, sprite_dict
    child = world.add_child dict
    child.put 'dict', dict
    child.handle_event 'rewind'
    child.handle_event 'inspect'
    child.put my.key.authority, world.make_world kind_authority
    #child.call 'rewind'
    world.send 'inspect', child

  delete_sprite: (world, sprite) ->
    world.remove_child sprite

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
  center: (world) ->
    world.get('cell_size') / 2

  # transform
  transform_base: (world) ->
    my.assert center = world.get('center')

    translate = [world.get('x'), world.get('y')]
    rotate    = world.get('angle')
    origin    = [center, center]

    { translate: translate, rotate: rotate, origin: origin }

  transform: (world) ->
    base = world.get 'transform_base'

    translate = "translate(#{base.translate[0]}px,#{base.translate[1]}px)"
    rotate    = "rotate(#{base.rotate}deg)"
    transform = "#{translate} #{rotate}"

    transform_origin = base.origin.map((o) -> "#{o}px").join ' '

    utils.prefix_style { transform: transform, transform_origin: transform_origin }

  ie_transform: (world) ->
    base = world.get 'transform_base'

    translate = "translate(#{base.translate[0]},#{base.translate[1]})"
    rotate    = "rotate(#{base.rotate}, #{base.origin[0]}, #{base.origin[1]})"

    "#{translate} #{rotate}"

  name_style: (world) ->
    cell_size = world.get 'cell_size'
    {x: 0.5 * cell_size, y: 0.5 * cell_size}

  # behavior defaults

  running: 'run'
  editing: 'run'

  proposed_position: (world, args) ->
    world.get('next_position') || world.get('position')

  collision: (world, obstruction) ->
    world.put 'next_position', null
    world.put 'bump', obstruction.labels()

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

  rewind: (world, args) ->
    dict = world.get 'dict'
    kind = world.get my.key.authority
    ['position', 'direction'].map (key) ->
      value = dict[key] or kind.get key
      world.put key, value
}
