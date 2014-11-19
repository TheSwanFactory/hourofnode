#
# inspect_commands.coffee
#
# Role: show commands available for this turtle
#
# Responsibility: populate commands pane of sprite inspector
#

{my} = require '../my'
{make} = require '../render/make'
  
exports.inspect_commands = (sprite) ->
  command_buttons = make.buttons('command', [
      "shape"
      "name"
      "fill"
      "position"
      "direction"
    ], my.button,
    (button, args) -> button.editing = true
    # TODO: Implement editable command
  )
