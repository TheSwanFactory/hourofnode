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
    sprite.send 'apply', message

  make.buttons(
    'command',
    names,
    my.command,
    (button, args) ->
      if sprite.get('editable') || sprite.get('edit_mode')
        send_message button.get('value')
        button.send 'execute'
        button.send 'click'
      else
        button.send 'error', my.not_editable(sprite)
  )
