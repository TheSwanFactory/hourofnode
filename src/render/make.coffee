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
  body = columns "#{kind}s", items
  body.stroke = my.color.line
  body['stroke-width'] = 1
  body.padding = 8
  body.fill = my_kind.background
  body.height = my_kind.size
  
  my.extend body._AUTHORITY, {
    _KIND: kind
    fill: my_kind.color
    margin: my_kind.margin
    height: my_kind.size - 2 * my_kind.margin - 2 * my_kind.padding
    width: my_kind.size
    #(world) -> world.up.get('width') / items.length - 2*my_kind.margin
    click: action
    _AUTHORITY: {padding: 0, height: 0, width: 0}
  }
  body


exports.make = {rows: rows, columns: columns, buttons: buttons}
