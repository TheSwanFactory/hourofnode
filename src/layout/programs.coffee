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
    _EXPORTS: ['tick', 'collision']
    selected: (world) -> world.label() == sprite.get 'running'
    editable: (world) -> world.label() == sprite.get 'editing'

    next_index: 0
    next_command: (world) ->
      current_index = world.get('next_index')
      next_index = current_index + 1

      instructions = world.find_child('instructions').find_children()

      # if this is our last instruction
      if instructions.length <= next_index
        next_index = 0
        sprite.put 'running', 'repeat'

      world.put 'next_index', next_index

      instructions[current_index]

    tick: (world, args) ->
      return unless world.get 'selected'
      action = world.get 'next_command'
      sprite.call 'prepare', action.get('value') if action

    collision: (world, args) ->
      [proposing_sprite, collision_subject, coordinates] = args
      return unless proposing_sprite == sprite # if this is my sprite to handle

      world.put 'next_index', 0 # reset
      sprite.put 'running', 'interrupt'

      if collision_subject == my.kind.wall
        return
      if not collision_subject.get('obstruction')
        sprite.call 'commit', coordinates

    apply: (world, args) ->
      return unless world.get 'editable'
      {target, action} = args
      world.call('store', action) if world == target
  }

  program_row = (name, contents) ->
    program = make.columns name, [
      { _LABEL: 'program_name', name: name }
      make.buttons("instruction", contents, my.command)
    ]
    my.extend program, program_behavior()

  behavior = sprite.get('behavior')
  my.assert _.isObject(behavior), "#{sprite} has no behavior property"

  children = []
  for name, contents of behavior
    children.push program_row(name, contents)
  children
