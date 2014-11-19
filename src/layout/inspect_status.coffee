#
# inspect_status.coffee
#
# Role: show and edit status of current sprite
#
# Responsibility: display and edit status
#

{my} = require '../my'
{make} = require '../render/make'

add_paths = (dict, sprite) ->
  paths = sprite.get('paths').all()
  my.extend dict, {
    name_style: {font_size: 0}
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
  
exports.inspect_status = (sprite) ->

  status_buttons = make.buttons('stat', [
      "shape"
      "name"
      "fill"
      "position"
      "direction"
    ], my.button,
    (button, args) -> button.editing = true
    # TODO: Implement editable status
  )

  console.log 'status sprite', sprite.doc.x
  for dict in status_buttons._CHILDREN
    key = dict.value
    console.log 'status dict key', key , sprite.get(key)
    if dict.value == 'shape'
      add_paths dict, sprite
    else
      dict.name = (button) -> extract(sprite, button) # run time
    console.log '-> status dict', dict

  status_buttons
