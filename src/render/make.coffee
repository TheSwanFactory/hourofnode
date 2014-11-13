{my} = require '../my'
{vector} = require '../god/vector'

group = (label, items, direction) -> {
  _KIND: label
  _AUTHORITY: {layout: direction}
  _LABEL: label
  _CHILDREN: items
}

rows = (label, items) -> group(label, items, vector.axis.down)
columns = (label, items) -> group(label, items, vector.axis.across)
buttons = (kind, items, my_kind, action) ->
  body = columns "#{name}s", items
  body.stroke = my.color.line
  body.padding = my_kind.padding
  body.fill = my_kind.background

  _.extend body._AUTHORITY, {
    _KIND: kind
    fill: my_kind.color
    margin: my_kind.margin
    height: my_kind.size
    width: my_kind.size
    click: action
  }
  body


exports.make = {rows: rows, columns: columns, buttons: buttons}
