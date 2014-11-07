{my} = require '../my'

exports.controls = {
  _LABEL: "controls"
  j: (world) -> world.get('split')
  width: (world) -> world.get('grid').size
  height: my.control.spacing
  fill: my.color.background
  stroke: "black"
  _AUTHORITY: {
    _KIND: "Control"
    fill: my.color.button
    x: (world, args) -> world.index*my.control.spacing + my.control.margin
    y: (world, args) -> my.control.margin
    height: my.control.size
    width: my.control.size
    click: (world, args) -> world.send world.get('value')
  }
  _CHILDREN: [
    "step", "run", "stop", "reset"
  ]
}
