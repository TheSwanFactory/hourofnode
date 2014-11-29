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

# method, key, integer
extract_instruction = (contents) ->
  instruction = contents.split " "
  instruction[2] = parseInt instruction[2]
  instruction
  
exports.programs = (sprite) ->

  load_program = (key) -> sprite.put 'running', key
  
  get_next_index = (current_index, count) ->
    next_index = current_index + 1
    return next_index if next_index < count
    load_program 'repeat'
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
      world.call 'perform', action.get('value') if action
      
    perform: (world, key) ->
      contents = sprite.get('actions').get(key)
      return load_program(key) unless _.isString contents
      world.call 'perform_instruction', contents

    perform_instruction: (world, contents) ->
      [method, key, value] = extract_instruction contents
      my.assert sprite[method], "#{sprite.label()}: no '#{method}' property"
      sprite[method](key, value)

    collision: (world, args) ->
      [proposing_sprite, collision_subject, coordinates] = args
      return unless proposing_sprite == sprite
      # if this is my sprite to handle
      if collision_subject.get('obstruction')
        world.call 'reset_index'
        load_program 'interrupt'
      else
        sprite.call 'commit', coordinates

    apply: (world, args) ->
      {target, action} = args
      return unless world.get 'editable'      
      world.call('store', action) if sprite == target

    store: (world, action) ->
      actions_container = world.find_child('actions')
      actions_container.add_child action
  }

  program_row = (name, contents) ->
    program = make.columns name, [
      { _LABEL: 'program_name', name: name }
      make.buttons "action", contents, my.command, (button, args) ->
        button.up.remove_child(button)
        button.send 'click'
        button.send 'brick', -1
    ]
    my.extend program, program_behavior()

  actions = sprite.get 'actions'
  my.assert sprite.is_world(actions), "#{sprite} has no actions world"

  children = []
  actions.keys().map (key) ->
    contents = actions.get(key)
    children.push program_row(key, contents) unless _.isString(contents)
  children