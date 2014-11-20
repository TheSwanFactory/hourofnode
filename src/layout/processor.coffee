#
# processor.coffee
#
# Every Sprite has a Processor as part of its Behavior
#
# Role: apply the next command to this sprite
#
# Responsibility: 
# * track current_program and next_command for a sprite
# * at each step:
#   * send next_command to the sprite
#   * handle any exceptions
#   * calculate the new next_comment
# * 

{my} = require '../my'

exports.processor = (initial_label, sprite) -> {
  running: initial_label
  running_program: (world) -> world.find_child(world.get 'running')

  next_index: 0
  next_command: (world) ->
    program = world.get 'running_program'
  
  step: (world, args) ->
    program = world.get 'current_program'
    local = world.get('programs')
    return unless world.is_world local
    my.assert signal = local.call('next'), "No next signal"
    world.call 'perform', signal
}

