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
  sprite_actions = sprite.get('actions')
  my.assert sprite.is_world(sprite_actions), "#{sprite} actions not a world"
  names = sprite_actions.keys([])
  names = names.filter (x) -> x[0] != '_' unless my.design

  add_program = (world, args) ->
    [sprite, program_name] = args

    return unless sprite == world.get 'sprite'

    world.add_sibling make.button(program_name, click, my.command)

  click = (button, args) ->
    if sprite.get('editable') || sprite.get('edit_mode')
      send_message button.get('value')
      button.send 'execute'
      button.send 'click'
    else
      button.send 'error', my.not_editable(sprite)

  send_message = (word) ->
    message = { target: sprite, action: word }
    sprite.send 'apply', message

  make.buttons 'command', names, my.command, click, {
    _EXPORTS:    ['add_program']
    add_program: add_program
  }

