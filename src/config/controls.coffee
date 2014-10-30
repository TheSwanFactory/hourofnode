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
    x: (world, args) -> world.index * my.control.spacing + world.get('margin')
    y: (world, args) -> world.get('margin')
    transform: (world, args) ->
      x = world.index * my.control.spacing + world.get('margin')
      y = world.get('margin')
      "translate(#{x},#{y})" # TODO: Refactor
    height: my.control.size
    width: my.control.size
    name_style: (world) -> 
      middle = world.get('height') / 1.8
      margin = world.get('margin')
      {x: middle - margin, y: middle}
    
    click: (world, args) -> world.send world.get('value')
  }
  _CHILDREN: [
    "step", "run", "stop", "reset"
  ]
}
