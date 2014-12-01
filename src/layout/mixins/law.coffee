{vector} = require '../../god/vector'
{my}     = require '../../my'

###

law.coffee

it's the law

1. propose
  - sprites broadcast what they would like to do
2. decide
  - check to make sure that the proposed movements don't cause collisions. if
    any do, call 'collision' on the offending sprite


3. resolve
  - tell sprites they are free to perform their proposed action


###

same_position = (mover, checker) ->
  _.isEqual mover.get('proposed_position').all(), checker.get('proposed_position').all()

resolve_collision = (mover, checker) ->
  blocked = true
  if checker.get 'obstruction'
    mover.call 'collision', checker
    return blocked
  return not blocked

###
#  RESOLUTION RULES:
  - no obstruction -> no problem
    not blocked if
  - one obstruction -> non-obstruction gets interrupted
  - both obstructions -> the moving object gets interrupted
###

collision_check = (sprites, cell_count, grid) ->
  _.each sprites, (mover, mover_index) ->
    my.assert mover, "moving sprite"

    blocked = false

    # 1. Check if out of bounds; if so, collide with edge
    if not vector.inside(mover.get 'proposed_position', cell_count)
      mover.call 'collision', grid
      return

    # 2. Check every other sprite whether in same position
    _.each sprites, (checker, checker_index) ->
      if checker != mover and same_position(mover, checker)
         blocked = resolve_collision(mover, checker)

    mover.call 'commit' if not blocked

law =
  _EXPORTS:  ['decide']
  sprite_list: (world, args) ->   world.up.find_child('sprites').find_children()

  decide: (world, args) ->
    console.log 'law decide'
    sprites = world.get 'sprite_list'
    cell_count = world.get 'cell_count'
    grid = world.up
    collision_check sprites, cell_count, grid

  # TODO: remove if not used
  resolve: (world, args) ->
    proposals = world.get_local 'proposals'
    _.each proposals, (proposal) ->
      proposal.sprite.call 'approve', proposal.coordinates

  coordinates: (world, args) ->
    world.get_local_plain('proposals').all().map (p) -> p.coordinates

exports.law = law
