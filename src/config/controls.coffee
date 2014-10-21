exports.controls = {
  _LABEL: "controls"
  stroke: "black"
  fill: "lightgrey"
  row: 0
  col: 0
  i: (world, args) ->
    world.get('split')+0.25
  j: 0.25
  path: (world, args) ->
    scale = world.get('scale') / 2.5
    half = scale / 2
    "m#{-half},#{-half}  h#{scale} v#{scale} h-#{scale } v#{-scale}"
    
  _CHILDREN: [
    {
      i: 0.1, j:0
      name: (world, args) ->
        world.get("current")
    }
    {i: 0.6, j:0}
  ]
}
