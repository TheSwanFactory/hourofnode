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
  words = words.filter (x) -> x[0] != '_' unless my.design
  command_buttons = make.buttons(
    'command',
    words,
    my.command,
    (button, args) ->
      word = button.get 'value'
      button.send('apply', {
        target: sprite
        action: language[word]
      })
  )
