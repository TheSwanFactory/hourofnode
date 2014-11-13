{my} = require '../my'
{make} = require './make'

make_button = (kind, items, my_kind, action) ->
  body = make.columns "#{name}s", items
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

body = make.columns 'controls', ["step", "run", "stop", "reset"]
body.padding = my.control.spacing
body.stroke = my.color.line
body.fill = my.color.background

# TODO: Invent a more elegant inheritance mechanism

_.extend body._AUTHORITY, {
  _KIND: "Control"
  fill: my.color.button
  margin: my.control.margin
  height: my.control.size
  width: my.control.size
  click: (world, args) -> world.send world.get('value')
}

exports.controls = body 
  

