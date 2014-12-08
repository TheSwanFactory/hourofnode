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
      fill:         sprite.get('fill')
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

extract = (sprite, key) ->
  [
    { tag_name: 'span', class: 'key',   name: key }
    { tag_name: 'span', class: 'value', name: get(sprite, key) }
  ]

exports.status = (sprite) ->

  status_buttons = make.columns('stat', [
      "-"
      "kind"
      "name"
      "fill"
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
      {
        _LABEL:    key
        _CHILDREN: extract(sprite, key)
        tag_name:  'div'
        class:     'attribute'
      }

  status_buttons
