assert = require 'assert'

exports.programs = {
  prog: (world, args) ->
    {signal} = args
    program = world.get('program')
    program.push signal
    console.log "prog: #{world}", world, args, signal, program
    
  load: (world, args) ->
    args = {name: 'default'} unless args?
    {name} = args
    child = world.find_child(name)
    assert child, "reload: #{name} missing"
    assert program = child.get('value'), "reload: program value missing"
    world.put('program', program)
    world.put('counter', 0)

  reload: (world, args) ->
    world.call('load', args)
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
    {_LABEL: 'collision', value: ["backward", "left", "left"]}
  ]
}

