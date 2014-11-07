assert = require 'assert'

offset = (world, key) -> world.get(key)*0.5 + 0.25
  
exports.inspector = {
  _LABEL: "inspector"
  stroke: "black"
  fill: "lightgrey"
  i: (world, args) -> world.get('split')+0.25
  j: 0.25
  path: (world, args) ->
    scale = world.get('scale') / 2.5
    half = scale / 2
    "m#{-half},#{-half}  h#{scale} v#{scale} h-#{scale } v#{-scale}"
  BUTTON: {
    i: (world) -> world.index / 2.0
    j: 0
  }
  _AUTHORITY: {
    i: 0
    j: (world) -> world.index / 1.5
    action_key: (world) -> world.get('_LABEL')
    action: (world) -> world.get('signals')[ world.get('action_key') ]
    name: (world) ->
      action = world.get('action')
      if action? then action['name'] else world.get('_LABEL')
    click: (world, args) ->
      action = world.get('action')
      turtle = world.get('current')
      program = turtle.get('program')
      console.log 'click', turtle, action, program.all()
      assert action
      turtle.call(action['do'], action)
      #program.push world.get('action_key')
  }
  _CHILDREN: [
    {
      _LABEL: "turtle_controls"
      _AUTHORITY: (world) -> world.get('BUTTON')
      _CSS: "cloneable"
      _CHILDREN: [
        {
          _LABEL: "current"
          stroke: "white"
          fill: "white"
          name: (world, args) -> world.get('current').label()
        }
        {_LABEL: "prog_left"}, {_LABEL: "prog_forward"}, {_LABEL: "prog_right"}
      ]
    }
    {
      _LABEL: "active_program"
      _AUTHORITY: (world) -> world.get('BUTTON')
      _CHILDREN: (world) ->
        turtle = world.get('current')
        program = turtle.get('program')
        counter = turtle.get('program_counter')
        index = 0
        result = program.map (signal) ->
          dict = {_LABEL: signal}
          dict['selected'] = true if index == counter
          index = index + 1
          dict
        result.all()
    }
    {
      _LABEL: "program_loader"
      program: (world) ->
        result = world.map_children (child) -> child.label()
        result
      _CHILDREN: [
        {
          _LABEL: 'default'
          _AUTHORITY: (world) -> world.get('BUTTON')
          _CHILDREN: [
            {_LABEL: "default",stroke: "white",fill: "white"}
            'forward','left','forward','right'
          ]
        }
        {
          _LABEL: 'conflict'
          _AUTHORITY: (world) -> world.get('BUTTON')
          _CHILDREN: [
            {_LABEL: "conflict",stroke: "white",fill: "white"}
            'reverse','left','left'
          ]
        }
      ]
    }
  ]
}