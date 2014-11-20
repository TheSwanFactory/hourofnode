#
# processor.coffee
#
# Every Sprite has a Processor as part of its Behavior
#
# Role: apply the next command to this sprite
#
# Responsibility: 
# * track the current program and next command
# * send that command to the sprite
# * 

{my} = require '../my'

exports.processor = (initial_label) -> {
  current_program: initial_label
  target_program: initial_label
  next_command: 0
}

