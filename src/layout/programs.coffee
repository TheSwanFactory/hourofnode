#
# programs.coffee
#
# A Behavior is a dictionary of Programs
# A Program is a sequence of Commands
# A Command is a word in the Language
# A Language is a dictionary of Commands and Actions
# An Action is a method-key-value triplet (instruction, signal)
#
# Role: create and run a single program
#
# Responsibility: 
# * create behavior row
# * track and return next command
# * advance counter (or fault)

{my} = require '../my'
{make} = require '../render/make'

exports.programs = (sprite) ->
  program_behavior = (name) -> {
    _AUTHORITY: {
      selected: (world) -> world.index == world.get('next_index')
    }
    selected: (world) -> world.label() == sprite.get 'running'
    editable: (world) -> world.label() == sprite.get 'editing'
    
    next_index: 0
    next_command: (world) ->
      program = world.get 'running_program'

    step: (world, args) ->
      return unless world.get 'selected'
      action = world.get 'next_command'
      valid_action = sprite.call 'perform', action
    
    apply: (world, args) ->
      return unless world.get 'editable'
      {target, action} = args
      world.call('store', action) if world == target
  }

  program_row = (name, contents) ->
    program = make.columns name, [
      { _LABEL: 'program_name', name: name }
      make.buttons("instructions", contents, my.command)
    ]
    my.extend program, program_behavior()

  behavior = sprite.get('behavior')
  my.assert _.isObject(behavior), "#{sprite} has no behavior property"
  
  children = []
  for name, contents of behavior
    children.push program_row(name, contents)
  children
  