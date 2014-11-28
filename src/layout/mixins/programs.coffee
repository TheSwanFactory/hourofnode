#
# programs.coffee
#
# A Behavior is a dictionary of Programs
# A Program is a sequence of Commands
# A Command is a word in the Language
# A Language is a dictionary of Commands and Actions
# An Action is a method-key-value triplet (action, signal)
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
    _EXPORTS: ['tick', 'collision', 'apply']
    _AUTHORITY: {
      selected: (world) -> world.index == world.get('next_index')
    }
    selected: (world) -> world.label() == sprite.get 'running'
    editable: (world) -> world.label() == sprite.get 'editing'

    next_index: 0
    reset_index: (world) -> world.put 'next_index', 0
    next_action: (world) ->
      current_index = world.get 'next_index'
      actions = world.find_child('actions').find_children()
      count = actions.length
      world.put 'next_index', get_next_index(current_index, count) 
      actions[current_index]

    tick: (world, args) ->
      return unless world.get 'selected'
      action = world.get 'next_action'
      sprite.call 'prepare', action.get('value') if action

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
      {target, action} = args
      console.log "programs apply: #{world}, {#{target}, #{action}}"
      console.log "edit: #{sprite.get 'editing'} -> #{world.get 'editable'}"
      return unless world.get 'editable'      
      world.call('store', action) if sprite == target

    store: (world, action) ->
      console.log "programs store: #{world}, {#{action}}"
      actions_container = world.find_child('actions')
      actions_container.add_child action
  }

  program_row = (name, contents) ->
    program = make.columns name, [
      { _LABEL: 'program_name', name: name }
      make.buttons "action", contents, my.command, (button, args) -> button.up.remove_child(button)

    ]
    my.extend program, program_behavior()

  behavior = sprite.get('behavior')
  my.assert _.isObject(behavior), "#{sprite} has no behavior property"

  children = []
  for name, contents of behavior
    children.push program_row(name, contents)
  children
