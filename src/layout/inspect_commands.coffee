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
    my.command,
    (button, args) ->
      value = button.get 'value'
      console.log 'send command', value
      button.send('command', button)
  )
