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
      stroke: "white"
      fill: "white"
      name: (world, args) ->
        cur = world.get("current")
        "Current turtle: #{cur}"
    }
    {col: 0, row: 1}
  ]
}
