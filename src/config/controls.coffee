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
    action_key: (world) -> world.get('_LABEL')
    action: (world) -> world.get('signals')[ world.get('action_key') ]
    name: (world) -> world.get('action')['name']
    click: (world, args) ->
      action = world.get('action')
      current = world.get('current')
      current.call(action['do'], action)
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
    {_LABEL: "left", row: 1, col: 0}
    {_LABEL: "front", row: 1, col: 1}
    {_LABEL: "right", row: 1, col: 2}
    {_LABEL: "step", row: 2, col: 0}
  ]
}
