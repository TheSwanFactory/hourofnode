{vector} = require './vector'
{my}     = require '../my'

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

collision_check = (proposals, cell_count) ->
  _.each proposals, (proposal, index) ->
    proposal          = proposal.get()
    sprite            = proposal.sprite
    collision_subject = null

    # check for collisions
    # compare this proposal's coordinates to all the other proposals
    _.each _.rest(proposals, index + 1), (other_proposal, inner_index) ->
      other_proposal = other_proposal.get()
      # if we're about to collide, say no
      if _.isEqual(proposal.coordinates, other_proposal.coordinates)
        drop_index = index + inner_index + 1
        other_proposal.sprite.send 'collision', [other_proposal.sprite, proposal.sprite, other_proposal.coordinates]
        proposals.splice drop_index, 1 # remove this from the chain to be considered

        collision_subject = other_proposal.sprite

    if not vector.inside(proposal.coordinates, cell_count)
      collision_subject = my.kind.wall

    if collision_subject? # proposal.sprite ran into something
      proposal.sprite.send 'collision', [proposal.sprite, collision_subject, proposal.coordinates]
    else
      proposal.sprite.call 'commit', proposal.coordinates

law =
  _EXPORTS:  ['prepare', 'propose', 'decide']
  proposals: []

  prepare: (world, args) ->
    world.put 'proposals', []

  propose: (world, args) ->
    [sprite, coordinates] = args
    proposals = world.get_plain 'proposals'
    proposals.push {sprite: sprite, coordinates: coordinates}
    console.log 'law add proposal', sprite
    world.put 'proposals', proposals

  decide: (world, args) ->
    console.log 'law decide'
    proposals = world.get_local_plain('proposals')
    cell_count = world.get_local_plain('cell_count')
    collision_check proposals.cells, cell_count

  resolve: (world, args) ->
    proposals = world.get_local_plain 'proposals'
    _.each proposals, (proposal) ->
      proposal.sprite.call 'approve', proposal.coordinates

  cell_count: (world, args) ->
    world.get_plain('sprites')[0].get_plain 'cell_count'

  sprites: (world, args) ->
    world.get_local_plain('proposals').all().map (p) -> p.sprite

  coordinates: (world, args) ->
    world.get_local_plain('proposals').all().map (p) -> p.coordinates

exports.law = law
