# inspect_status.coffee
#
# Role: show and edit status of current sprite
# Responsibility:
# * track current sprite
#

{my} = require '../my'
{make} = require '../render/make'

exports.inspect_status = (sprite) ->

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

  for dict in [] #status_buttons._CHILDREN
    console.log 'status dict', status_buttons, dict
    if dict.value == 'shape'
      dict.paths = sprite.get('paths').all()
    else
      dict.name = (button) -> sprite.get(dict._LABEL) or "N/A"

  status_buttons
