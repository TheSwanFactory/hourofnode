{my} = require('../my')
exports.controls = {
  _LABEL: "controls"
  j: (world) -> world.get('split')
  width: (world) -> world.get('grid').size
  height: my.control.spacing
  fill: my.color.background
  stroke: "black"
  path: (world, args) -> world.get('rect_path')
  _AUTHORITY: {
    fill: my.color.button
    x: (world, args) -> world.index*my.control.spacing + my.control.margin
    y: (world, args) -> my.control.margin
    height: my.control.size
    width: my.control.size
    name_style: (world) -> 
      {x: world.get('height') / 2, y: world.get('width') / 2}
    click: (world, args) -> world.send world.get('value')
  }
  _CHILDREN: [
    "step", "run", "stop", "reset"
  ]
}
