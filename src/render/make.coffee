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
  body = group "#{kind}s", items, 'button'
  body.stroke = my.color.line
  body.fill = my_kind.background
  body.height = my_kind.size
  body.width = (button) -> button.get('available_width')
  my.extend body._AUTHORITY, {
    _KIND: kind
    fill: my_kind.color
    padding: my_kind.padding
    margin: my_kind.margin
    height: my_kind.size - 4 * my_kind.padding
    width: my_kind.size + 2 * my_kind.padding
    x: (button) -> button.get 'offset'
    y: 0
    click: action
    # _AUTHORITY: {padding: 0, height: 0, width: 0}
  }
  body


exports.make = {rows: rows, columns: columns, buttons: buttons}
