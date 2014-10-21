{activity} = require('./activity')

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
    click: (world, args) ->
      action = world.get('action')
      current = world.get('current')
      console.log "click #{world} -> #{current} do #{action}"
      current.call(action[0], action[1])
  }
  _CHILDREN: [
    {
      _LABEL: "current"
      stroke: "white"
      fill: "white"
      name: (world, args) ->
        current = world.get('current')
        "#{current} #{current.get('i')}x#{current.get('j')} -> #{current.get('v_i')}x#{current.get('v_j')}"
    }
    {
      _LABEL: "LEFT"
      row: 1, col: 0
      name: "L"
      action: ["turn", {dir: 1}]
    }
    {
      _LABEL: "GO"
      row: 1, col: 1
      name: "Go"
      action: ["go", {dir: 1}]
    }
    {
      _LABEL: "RIGHT"
      row: 1, col: 2
      name: "R"
      action: ["turn", {dir: -1}]
    }
    {
      row: 2, col: 0
      name: "Step"
      action: ["step", {n: 1}]
    }
    {
      row: 2, col: 1
      name: "Play"
    }
    {
      row: 2, col: 2
      name: "Stop"
    }
    
  ]
}
