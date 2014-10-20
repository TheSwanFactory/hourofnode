exports.controls = {
  _LABEL: "controls"
  stroke: "black"
  fill: "lightgrey"
  row: 0
  col: 0
  path: (world, args) ->
    size = world.get('size')
    scale = world.get('scale') / 2.5
    "m#{size+15},0 h#{scale} v#{scale} h-#{scale } v#{-scale}"
    
  _CHILDREN: [
    {i: 0, j:0}
    {i: 0.5, j:0}
  ]
}
