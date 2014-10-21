offset = (world, key) -> world.get(key)*0.5 + 0.25
  
exports.controls = {
  _LABEL: "controls"
  stroke: "black"
  fill: "lightgrey"
  i: (world, args) -> world.get('split')+0.25
  j: 0.25
  path: (world, args) ->
    scale = world.get('scale') / 2.5
    half = scale / 2
    "m#{-half},#{-half}  h#{scale} v#{scale} h-#{scale } v#{-scale}"
  _AUTHORITY: {
    row: 0
    col: 0
    i: (world, args) -> offset(world, 'col')
    j: (world, args) -> offset(world, 'row')
  }
  _CHILDREN: [
    {
      _LABEL: "current"
      stroke: "white"
      fill: "white"
      name: (world, args) -> "For: #{world.get('current') or 'N/A'}"
    }
    {
      row: 1, col: 0
      name: "L"
    }
    {
      row: 1, col: 1
      name: "Go"
    }
    {
      row: 1, col: 2
      name: "R"
    }
  ]
}
