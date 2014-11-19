# status.coffee
#
# Role: show and edit status of current sprite
# Responsibility:
# * track current sprite
#

{my} = require '../my'
{make} = require '../render/make'

status_buttons = make.buttons('status', [
    "shape"
    "name"
    "color"
    "position"
    "direction"
  ], my.button,
  (button, args) -> button.editing = true
  # TODO: Implement editable status
)

show_paths = (button) ->
  return unless 'shape' == button.get('_LABEL')
  inspected = button.get 'inspected'
  inspected.get 'paths'
  
text_for = (button) ->
  inspected = button.get 'inspected'
  inspected.get button.get('_LABEL')

my.extend status_buttons._AUTHORITY, {
  x: (button) -> button.get 'offset'
  name: (button) -> text_for(button) unless show_paths(button)
  paths: (button) -> show_paths(button)
}

status_buttons._EXPORTS = ['inspect']
status_buttons.inspect = (world, sprite) -> world.put 'inspected', sprite

exports.status = status_buttons
