exports.controls = {
  _LABEL: "controls"
  stroke: "black"
  fill: "lightgrey"
  row: 0
  col: 0
  i: (world, args) ->
    return world.get('split')+0.25 if world.label() == "controls"
    world.get('col')*0.5 + 0.25
  j: 0.25
  path: (world, args) ->
    scale = world.get('scale') / 2.5
    half = scale / 2
    "m#{-half},#{-half}  h#{scale} v#{scale} h-#{scale } v#{-scale}"
    
  _CHILDREN: [
    {
      name: (world, args) ->
        world.get("current")
    }
    {col: 1}
  ]
}
