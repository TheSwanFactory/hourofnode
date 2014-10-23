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
    j: (world) -> world.get('_INDEX') / 1.5
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
      _CHILDREN: [{_LABEL: "step"}, {_LABEL: "run"}, {_LABEL: "stop"}, {_LABEL: "reset"}]
    }
    {
      _LABEL: "turtle_controls"
      _AUTHORITY: (world) -> world.get('BUTTON')
      _CHILDREN: [
        {
          _LABEL: "current"
          stroke: "white"
          fill: "white"
          name: (world, args) -> world.get('current').label()
        }
        {_LABEL: "left"}, {_LABEL: "front"}, {_LABEL: "right"}
      ]
    }
    {
      _LABEL: "active_program"
      _AUTHORITY: (world) -> world.get('BUTTON')
      _CHILDREN: (world) ->
        turtle = world.get('current')
        program = turtle.get('program')
        program.map (signal) -> {_LABEL: name}
    }
    {_LABEL: "program_selector"}
  ]
}
