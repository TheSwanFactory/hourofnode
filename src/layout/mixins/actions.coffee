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
  actions = actions.keys([])
  actions = actions.filter (x) -> x[0] != '_' unless my.design
  
  send_message = (word) ->
    action = actions[word].split " "
    action[2] = parseInt action[2]
    message = { target: sprite, name: word, action: action }
    console.log 'send_message', message, sprite
    sprite.send 'apply', message
  
  buttons = make.buttons(
    'command',
    actions,
    my.command,
    (button, args) ->
      if sprite.get 'editable'
        send_message button.get('value')
        button.send 'decide'
      else
        button.send 'error', "#{sprite} not editable"
  )
  
  my.extend buttons, {
  }
