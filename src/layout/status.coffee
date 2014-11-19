# status.coffee
#
# Role: show and edit status of current sprite
# Responsibility:
# * track current sprite
#

{my} = require '../my'
{make} = require '../render/make'

status_buttons = make.buttons('stat', [
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
  return  unless 'shape' == button.get('_LABEL')
  inspected = button.get 'inspected'
  inspected.get 'paths'
  
text_for = (button) ->
  return button.get('_LABEL')
  inspected = button.get 'inspected'
  inspected.get (button.get('_LABEL'))

for dict in status_buttons._CHILDREN
  console.log 'status dict', status_buttons, dict
  my.extend dict, {
    name: (button) -> text_for(button)# unless show_paths(button)?
    #paths: (button) -> show_paths(button)
  }

status_buttons._EXPORTS = ['inspect']
status_buttons.inspect = (world, sprite) -> world.put 'inspected', sprite

exports.status = status_buttons
