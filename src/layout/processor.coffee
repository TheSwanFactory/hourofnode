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

exports.processor = (initial_label, sprite) ->
  my.assert sprite, "missing sprite" 
  find_program = (world, key) -> world.find_child sprite.get(key)
  {
    running_program: (world) -> find_program world, 'running'
    editing_program: (world) -> find_program world, 'editing'
  
  }

