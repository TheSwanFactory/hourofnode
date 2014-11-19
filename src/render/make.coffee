{my} = require '../my'
{vector} = require '../god/vector'

group = (label, items, tag_name) -> {
  _KIND: label
  _AUTHORITY: {tag_name: tag_name}
  _LABEL: label
  _CHILDREN: items
}

rows = (label, items) -> group label, items, 'div'
columns = (label, items) -> group label, items, 'span'

buttons = (kind, items, my_kind, action) ->
  label = "#{kind}s"
  authority = {
    tag_name: 'button'
    _KIND: kind
    fill: my_kind.color
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
  }
  {
    _KIND: label
    _AUTHORITY: authority
    _LABEL: label
    _CHILDREN: children
    stroke: my.color.line
    fill: my_kind.background
    height: my_kind.size
    width: (button) -> button.get('available_width')
  }

exports.make = {rows: rows, columns: columns, buttons: buttons}
