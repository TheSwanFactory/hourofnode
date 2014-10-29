assert = require 'assert'

ROW_SIZE = 64

offset = (world, key) -> world.get(key)*0.5 + 0.25
  
exports.inspector = {
  _LABEL: "inspector"
  i: (world) -> world.get('split')
  width: (world) -> world.get('size')
  height: (world) -> world.get('size')
  margin: 8
  fill: "#888888"
  stroke: "black"
  path: (world, args) -> world.get('rect_path')
  _AUTHORITY: {
    fill: "#cccccc"
    scale: ROW_SIZE
    transform: (world, args) ->
      scale = world.get('scale')
      margin = world.get('margin')
      x = margin
      y = world.index * scale + margin
      "translate(#{x},#{y})" # TODO: Refactor
    height: (world) -> world.get('scale') - 2 * world.get('margin')
    width: (world) -> world.get('height')
    name_style: (world) -> 
      margin = world.get('margin')
      middle = world.get('scale') / 2
      {x: middle - margin, y: middle}
    
    click: (world, args) -> world.send world.get('value')
  }
  _CHILDREN: [
    "edit", "move", "next","code"
  ]

}
