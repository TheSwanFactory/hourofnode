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

# get editing property direct from the grid
editing = (sprite) ->
  sprite.up.up.get 'editing'

# Small sprite
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

# Other buttons
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
      sprite.send 'log_sprite_change', [sprite, key, value]
      sprite.put(key, value)
    field.editing = ->
      editing sprite
    utils.editable_field field

  [label, field]

key_and_value = (sprite, key, editable) ->
  _LABEL:    key
  _CHILDREN: extract(sprite, key, editable)
  tag_name:  'div'
  class:     'attribute'

# delete button

delete_button = (sprite) ->
  class:    'delete'
  tag_name: 'button'
  name:     'delete'
  click:    -> sprite.send 'delete_sprite', sprite
  selected: -> editing sprite

exports.status = (sprite) ->
  status_buttons = make.columns('stat', [
      "-"
      "kind"
      "name"
      "color"
      "editable"
      "obstruction"
      "delete"
    ],
    { height: '' }
    # TODO: Implement editable status
  )

  status_buttons._CHILDREN = status_buttons._CHILDREN.map (key) ->
    if key == '-'
      add_paths sprite
    else if key == 'delete'
      delete_button sprite
    else
      key_and_value(sprite, key, key in ['name', 'color'])

  status_buttons
