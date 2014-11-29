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

collision_check = (proposals, cell_count, grid) ->
  _.each proposals, (proposal, index) ->
    sprite            = proposal.sprite
    collision_subject = null

    # check for collisions
    # compare this proposal's coordinates to all the other proposals
    _.each _.rest(proposals, index + 1), (other_proposal, inner_index) ->
      # if we're about to collide, say no
      if _.isEqual(proposal.coordinates, other_proposal.coordinates)
        drop_index = index + inner_index + 1
        other_proposal.sprite.send 'collision', [other_proposal.sprite, proposal.sprite, other_proposal.coordinates]
        proposals.splice drop_index, 1 # remove this from the chain to be considered

        collision_subject = other_proposal.sprite

    if not vector.inside(proposal.coordinates, cell_count)
      collision_subject = grid

    if collision_subject? # proposal.sprite ran into something
      proposal.sprite.send 'collision', [proposal.sprite, collision_subject, proposal.coordinates]
    else
      proposal.sprite.call 'commit', proposal.coordinates

law =
  _EXPORTS:  ['decide']
  proposals: (world, args) ->
    world.up.find_child('sprites').map_children (sprite) ->
      { sprite: sprite, coordinates: sprite.get('determine_next_position').all() }
  # TODO: Replace with loosely-coupled world.send 'proposal'

  decide: (world, args) ->
    console.log 'law decide'
    proposals = world.get_plain 'proposals'
    cell_count = world.get_plain 'cell_count'
    grid = world.up
    collision_check proposals, cell_count, grid

  # TODO: remove if not used
  resolve: (world, args) ->
    proposals = world.get_local 'proposals'
    _.each proposals, (proposal) ->
      proposal.sprite.call 'approve', proposal.coordinates

  coordinates: (world, args) ->
    world.get_local_plain('proposals').all().map (p) -> p.coordinates

exports.law = law
