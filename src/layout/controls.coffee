{my} = require '../my'
{rows, cols} = require './rows_cols'

body = cols 'status', ["step", "run", "stop", "reset"]
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
  

