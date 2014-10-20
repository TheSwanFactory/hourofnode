exports.controls = {
  _LABEL: "controls"
  stroke: "black"
  fill: "lightgrey"
  path: (world, args) ->
    scale = world.get('scale') / 2
    "M0,0 h#{scale} v#{scale} h-#{scale } v#{-scale}"
  row: 0
  col: 0
  i: (world, args) ->
    console.log world.get('split')
    world.get('col') + 1
    
  _CHILDREN: [
    {col: 0, row:0}
  ]
}
