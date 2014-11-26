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

{my} = require '../../my'
{make} = require '../../render/make' # TODO: find better path-ing

exports.programs = (sprite) ->
  
  get_next_index = (current_index, count) ->
    next_index = current_index + 1
    return next_index if next_index < count
    sprite.put 'running', 'repeat'
    return 0
    
  program_behavior = (name) -> {
    _AUTHORITY: {
      selected: (world) -> world.index == world.get('next_index')
    }
    _EXPORTS: ['tick', 'collision']
    selected: (world) -> world.label() == sprite.get 'running'
    editable: (world) -> world.label() == sprite.get 'editing'

    next_index: 0
    reset_index: (world) -> world.put 'next_index', 0
    next_instruction: (world) ->
      current_index = world.get 'next_index'
      instructions = world.find_child('instructions').find_children()

      count = instructions.length
      world.put 'next_index', get_next_index(current_index, count) 

      instructions[current_index]

    tick: (world, args) ->
      return unless world.get 'selected'
      instruction = world.get 'next_instruction'
      sprite.call 'prepare', instruction.get('value') if instruction

    collision: (world, args) ->
      [proposing_sprite, collision_subject, coordinates] = args
      return unless proposing_sprite == sprite
      
      # if this is my sprite to handle
      if collision_subject.get('obstruction')
        world.call 'reset_index'
        sprite.put 'running', 'interrupt'
      else
        sprite.call 'commit', coordinates

    apply: (world, args) ->
      return unless world.get 'editable'
      console.log 'programs apply'
      
      {target, action} = args
      world.call('store', action) if world == target

    store: (world, action) ->
      instructions_container = world.find_child('instructions')
      # instructions_container.add_child action
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
