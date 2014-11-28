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
    message = { target: sprite, action: word }
    console.log 'send_message', message, sprite
    sprite.send 'apply', message
  
  # TODO: everyone should step on direct action
  # Implies button should:
  # * move current buffer to the end
  # * append action
  # * step everyone
  # 
  # which implies the programs buffer should
  # * not wrap next_pointer until beforehand
  # * have explicit repeats after first and repeat
  # * move up to just before calling repeat (?)
  
  buttons = make.buttons(
    'command',
    actions,
    my.command,
    (button, args) ->
      if sprite.get 'editable'
        send_message button.get('value')
        button.send 'decide'
        button.send 'click'
      else
        button.send 'error', "#{sprite} not editable"
  )
  
  my.extend buttons, {
  }
