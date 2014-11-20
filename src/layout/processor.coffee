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
  current_program: initial_label
  target_program: initial_label
  next_command: 0
}

