#
# language.coffee
#
# Role: show commands available for this turtle
#
# Responsibility: 
# * populate commands pane of sprite inspector
# * generate command events
#   * move the active turtle
#   * update the current behavior
#

# TODO: rename to inspect language

{my} = require '../my'
{make} = require '../render/make'
  
exports.language = (sprite) ->
  language = sprite.get('language')
  words = Object.keys language
  words = words.filter (x) -> x[0] != '_' unless my.design
  
  send_message = (word) ->
    message = { target: sprite, action: language[word] }
    console.log 'send_message', word, message, sprite
    sprite.send('apply', message)
      
  make.buttons(
    'command',
    words,
    my.command,
    (button, args) ->
      unless sprite.get 'editable'
        return sprite.send 'error', "#{sprite} not editable"
      send_message button.get('value')
  )
