#
# inspect_commands.coffee
#
# Role: show commands available for this turtle
#
# Responsibility: 
# * populate commands pane of sprite inspector
# * generate command events
#   * move the active turtle
#   * update the current behavior
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
      word = button.get 'value'
      world.send('apply', [sprite, language[word]])
  )
