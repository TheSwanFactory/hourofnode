#
# actions.coffee
#
# Role: show commands available for this turtle
#
# Responsibility: 
# * populate commands pane of sprite inspector
# * generate command events
#   * move the active turtle
#   * update the current behavior
#

{my} = require '../../my'
{make} = require '../../render/make'
  
exports.actions = (sprite) ->
  actions = sprite.get('actions')
  my.assert sprite.is_world(actions), "#{sprite} actions not a world"
  names = actions.keys([])
  names = names.filter (x) -> x[0] != '_' unless my.design
  
  send_message = (word) ->
    message = { target: sprite, action: word }
    console.log 'send_message', message, sprite
    sprite.send 'apply', message
    
  buttons = make.buttons(
    'command',
    names,
    my.command,
    (button, args) ->
      if sprite.get 'editable'
        send_message button.get('value')
        button.send 'execute'
        button.send 'click'
        button.send 'brick'
      else
        button.send 'error', "#{sprite} not editable"
  )
  
  _.extend buttons, {
  }
