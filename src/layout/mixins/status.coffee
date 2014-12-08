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

extract = (sprite, button) ->
  key = button.get my.key.label
  value = sprite.get key
  value = value.all() if sprite.is_array(value)
  value = switch value
    when true  then 'yes'
    when false then 'no'
    else value
  # FIXME: this is a real bad cheat
  sprite.rx().rxt.rawHtml "<span><b>#{_.capitalize key}</b><br/>#{_.capitalize value}</span>"

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
        _LABEL: key
        name: (button) -> extract(sprite, button)
        tag_name: 'div'
      }

  status_buttons
