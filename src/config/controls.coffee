exports.controls = {
  _LABEL: "controls"
  j: (world) -> world.get('split')
  width: (world) -> world.get('size')
  height: 96
  margin: 8
  fill: "#888888"
  stroke: "black"
  path: (world, args) -> world.get('rect_path')
  _AUTHORITY: {
    fill: "#cccccc"
    scale: 96
    transform: (world, args) ->
      scale = world.get('scale')
      margin = world.get('margin')
      x = world.get("_INDEX") * scale + margin
      y = margin
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
    "step", "run", "stop","loop", "reset"
  ]
}
