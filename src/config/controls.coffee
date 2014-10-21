offset = (world, key) -> world.get(key)*0.5 + 0.25
  
exports.controls = {
  _LABEL: "controls"
  stroke: "black"
  fill: "lightgrey"
  row: 0
  col: 0
  i: (world, args) ->
    return world.get('split')+0.25 if world.label() == "controls"
    offset(world, 'col')
  j: (world, args) -> offset(world, 'row')
  path: (world, args) ->
    scale = world.get('scale') / 2.5
    half = scale / 2
    "m#{-half},#{-half}  h#{scale} v#{scale} h-#{scale } v#{-scale}"
    
  _CHILDREN: [
    {
      stroke: undefined
      fill: undefined
      name: (world, args) ->
        world.get("current")
    }
    {col: 1, row: 1}
  ]
}
