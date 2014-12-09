#
# inspect_status.coffee
#
# Role: show and edit status of current sprite
#
# Responsibility: populate status pane of sprite inspector
#

{my} = require '../../my'
{make} = require '../../render/make'
{utils} = require '../../utils'

add_paths = (sprite) ->
  paths = sprite.get('paths').all()
  transform = utils.prefix_style transform: 'scale(0.5)'
  {
    tag_name: 'div'
    class:    'sprite'
    _CHILDREN: [{
      transform:    transform
      ie_transform: "scale(0.5)"
      paths:        paths
      color:        sprite.bind() -> sprite.get('color')
    }]
  }

get = (sprite, key) ->
  ->
    value = sprite.get key
    value = value.all() if sprite.is_array(value)
    value = switch value
      when true  then 'yes'
      when false then 'no'
      else value
    value

basic_field = (sprite, key) ->
  tag_name:   'span'
  class:      'value'
  name:       get(sprite, key)

extract = (sprite, key, editable) ->
  label = { tag_name: 'span', class: 'key',   name: key }

  field = basic_field sprite, key

  if editable
    field.after_save = (world, value) ->
      sprite.put(key, value)
    utils.editable_field field

  [label, field]

key_and_value = (sprite, key, editable) ->
  _LABEL:    key
  _CHILDREN: extract(sprite, key, editable)
  tag_name:  'div'
  class:     'attribute'

exports.status = (sprite) ->
  status_buttons = make.columns('stat', [
      "-"
      "kind"
      "name"
      "color"
      "editable"
      "obstruction"
    ],
    { height: '' }
    # TODO: Implement editable status
  )

  status_buttons._CHILDREN = status_buttons._CHILDREN.map (key) ->
    if key == '-'
      add_paths sprite
    else
      key_and_value(sprite, key, key in ['name', 'color'])

  status_buttons
