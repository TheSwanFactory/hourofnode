{my} = require '../my'
{vector} = require '../god/vector'

group = (label, items, tag_name, options = {}) ->
  my.extend({},
    {
      _KIND: label
      _AUTHORITY: {tag_name: tag_name}
      _LABEL: label
      _CHILDREN: items
    },
    options
  )

exports.make = {
  rows: (label, items, options) -> group label, items, 'div', options
  columns: (label, items) ->
    group label, items, 'span'

  buttons: (kind, items, my_kind, action) ->
    label = "#{kind}s"
    authority = {
      tag_name: 'button'
      _KIND: kind
      padding: my_kind.padding
      margin: my_kind.margin
      height: my_kind.size - 4 * my_kind.padding
      width: my_kind.size + 2 * my_kind.padding
      x: (button) -> button.get 'offset'
      y: 0
      click: action
    }
    children = items.map (item) -> {
      _LABEL: item
      name: item
      value: item
      class: my_kind.class
    }
    {
      _KIND: label
      _AUTHORITY: authority
      _LABEL: label
      _CHILDREN: children
      stroke: my.color.line
      height: my_kind.size
      width: (button) -> button.get('available_width')
    }
}
