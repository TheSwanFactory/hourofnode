assert = require 'assert'

DEFAULT = 'default:'

exports.programs = {
  _EXPORTS: ['reset', 'command']

  reset: (world, args) -> world.call('load', args)
  command: (world, args) ->
    {name, command} = args
    child = world.find_child(name)
    assert child, "reload: #{name} missing"
    assert program = child.get('value'), "reload: program value missing"
    program.push command

  load: (world, args) ->
    args = {name: DEFAULT} unless args?
    {name} = args
    program = world.find_child(name)
    assert program, "No program #{name} in #{world}"
    world.put('counter', 1)
    world.put('current', name)
    world.put('program', program)
    program 

  reload: (world, args) ->
    world.call('load', args)
    world.call('next', {count: 1})
    
  next: (world, args) ->
    program = world.get('program')
    counter = world.get('counter')
    if program? and counter? and counter < program._child_count()
      action = program._child_array()[counter].label()
    else
      return world.call('reload', args) unless args?
      assert false, "Infinite Loop: next <-> reload"
    assert signal = world.get('signals')[action], "No signal"
    counter += 1
    if counter >= program._child_count()
      world.call('load', args)
    else
      world.put('counter', counter)
    signal
    
  # TODO: Break this out into a test config
  # TODO: Find a more elegant way to match the label and display name
  _CHILDREN: [
    {_LABEL: 'buffer:', _CHILDREN: ['buffer:']}
    {_LABEL: DEFAULT, _CHILDREN: [DEFAULT, "forward", "right"]}
  ]
}

