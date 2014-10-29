assert = require 'assert'

exports.programs = {
  # TODO: Move to Sprites
  signals: {
    prog_left:  {name: "L", do:"prog", signal: "left"}
    prog_right: {name: "R", do:"prog", signal: "right"}
    prog_forward: {name: "F", do:"prog", signal: "forward"}
    left:  {name: "<-", do: "turn", dir: 1}
    right: {name: "->", do: "turn", dir: -1}
    forward: {name: "^", do: "go", dir: 1}
    reverse: {name: "v", do: "go", dir: -1}
  }
  prog: (world, args) ->
    {signal} = args
    program = world.get('program')
    program.push signal
    console.log "prog: #{world}", world, args, signal, program
    
  reload: (world, args) ->
    args = {name: 'default'} unless args?
    {name} = args
    child = world.find_child(name)
    assert child, "reload: #{name} missing"
    assert program = child.get('value'), "reload: program value missing"
    world.put('program', program)
    world.put('counter', 0)
    world.call('next', args)
    
  next: (world, args) ->
    program = world.get('program')
    counter = world.get('counter')
    if program? and counter? and counter < program.length()
      action = program.at(counter)
    else
      return world.call('reload', args) unless args?
      assert false, "Infinite Loop: next <-> reload"
    assert signal = world.get('signals')[action], "No signal"
    world.put('counter', counter + 1)
    signal
    
  _CHILDREN: [
    {_LABEL: 'default', value: ["forward", "right"]}
  ]
}

