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
  language = sprite.get('language')
  words = Object.keys language
  command_buttons = make.buttons(
    'command',
    words,
    my.button,
    (button, args) -> button.send('command', button)
  )
