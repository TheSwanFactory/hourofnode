#
# inspect_status.coffee
#
# Role: show and edit status of current sprite
#
# Responsibility: populate status pane of sprite inspector
#

{my} = require '../../my'
{make} = require '../../render/make'

add_paths = (dict, sprite) ->
  paths = sprite.get('paths').all()
  my.extend dict, {
    _CHILDREN: [{
      transform: 'translate(0,0) scale(0.5)'
      paths: paths
      fill: sprite.get 'fill'
    }]
  }
extract = (sprite, button) ->
  key = button.get 'value'
  value = sprite.get key
  value = value.all() if sprite.is_array(value)
  "#{value}"
  
exports.status = (sprite) ->

  status_buttons = make.buttons('stat', [
      "-"
      "name"
      "fill"
      "position"
      "direction"
    ], my.button,
    (button, args) -> button.editing = true
    # TODO: Implement editable status
  )

  for dict in status_buttons._CHILDREN
    key = dict.value
    if dict.value == '-'
      add_paths dict, sprite
    else
      dict.name = (button) -> extract(sprite, button) # run time

  status_buttons
