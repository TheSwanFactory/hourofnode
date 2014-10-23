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
  BUTTON: {
    i: (world) -> world.get('_INDEX') / 2.0
    j: 0
  }
  _AUTHORITY: {
    i: 0
    j: (world) -> world.get('_INDEX')
    action_key: (world) -> world.get('_LABEL')
    action: (world) -> world.get('signals')[ world.get('action_key') ]
    name: (world) ->
      action = world.get('action')
      if action? then action['name'] else world.get('_LABEL')
    click: (world, args) ->
      action = world.get('action')
      current = world.get('current')
      current.call(action['do'], action)
  }
  _CHILDREN: [
    {
      _LABEL: "game_controls"
      _AUTHORITY: (world) -> world.get('BUTTON')
      _CHILDREN: [
        {_LABEL: "step"}
        {_LABEL: "run"}
        {_LABEL: "stop"}
        {_LABEL: "reset"}
      ]
    }
    {
      _LABEL: "current_selection"
      stroke: "white"
      fill: "white"
      name: (world, args) ->
        current = world.get('current')
        "#{current} #{current.get('i')}x#{current.get('j')} -> #{current.get('v_i')}x#{current.get('v_j')}"
    }
    {
      _LABEL: "available_commands"
      _AUTHORITY: (world) -> world.get('BUTTON')
      _CHILDREN: [
        {_LABEL: "left", col: 0}
        {_LABEL: "front", col: 1}
        {_LABEL: "right", col: 2}
      ]
    }
    {_LABEL: "active_program", row: 3}
    {_LABEL: "program_selector", row: 4}
  ]
}
