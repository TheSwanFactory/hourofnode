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
  program_behavior = (name) -> {
    _EXPORTS: ['fetch', 'prefetch', 'apply', 'reset']
    selected: (world) -> world.label() == sprite.get 'running'
    editable: (world) -> world.label() == sprite.get 'editing'

    # Index

    next_index:    0
    reset:   (world) -> world.call 'fetch_program', 'run'

    reset_index:   (world) -> world.put 'next_index', 0
    advance_index: (world) ->
      next_index = world.get 'next_index'
      world.put 'next_index', next_index + 1

    # Action

    find_action:   (world) ->
      actions = world.find_child('actions').find_children()
      actions[world.get('next_index')]
    next_action: (world) ->
      action = world.call 'find_action'
      world.call 'advance_index'
      action

    fetch: (world, args) ->
      return unless world.get 'selected'
      action = world.call 'next_action'
      world.call 'perform', action.get 'value' if action

    prefetch: (world) ->
      return unless world.get 'selected'
      if bump = sprite.get('bump')
        key = world.call 'find_bump', bump.all()
        sprite.put 'bump', undefined
        return world.call('fetch_program', key)
      world.call 'fetch_program', 'run' unless world.get('find_action')

    fetch_program: (world, key) ->
      sprite.put 'running', key
      p = world.up.find_child(key)
      p.call 'reset_index'

    find_bump: (world, keys) ->
      # TODO: put real logic here
      'bump'

    perform: (world, key) ->
      contents = sprite.get('actions').get(key)
      return world.call('fetch_program', key) unless _.isString contents
      world.call 'perform_instruction', contents

    perform_instruction: (world, contents) ->
      [method, key, value] = extract_instruction contents
      if not sprite[method]
        return console.log "#{sprite.label()}: no '#{method}' property"
      sprite[method](key, value)

    apply: (world, args) ->
      {target, action} = args
      return unless world.get 'editable'
      world.call('store', action) if sprite == target

    store: (world, action) ->
      actions_container = world.find_child('actions')

      limit = world.get('action_limit')
      s = if limit == 1 then '' else 's'
      message = "Sorry, you can only have #{limit} brick#{s} per program"
      if actions_container._child_count() >= world.get('action_limit')
        return world.send 'error', message

      world.send 'brick'
      actions_container.add_child action

    # Drag & Drop Sorting

    sort_start: (world, args) ->
      [event, ui] = args
      index = ui.item.index()
      world.put 'sort_start_index', index

    sort_update: (world, args) ->
      [event, ui] = args
      index = ui.item.index()
      world.move_child world.get('sort_start_index'), index
  }

  program_row = (name, contents) ->
    buttons = make.buttons "action", contents, my.action, ((button, args) ->
        if sprite.get('editable') #and confirm('Are you sure you want to remove that action?')
          button.up.remove_child(button)
          button.send 'click'
          button.send 'brick', -1
      ), {
        selected: (world) -> world.index == world.get('next_index')
      }
    extensions = {}
    if sprite.get 'editable'
      extensions.init = (world, element) ->
          $(element).sortable
            cancel: 'a' # so that you can move buttons
            start:  (event, ui) -> world.call 'sort_start',  [event, ui]
            update: (event, ui) -> world.call 'sort_update', [event, ui]
    program = make.rows name, [
      {
        _LABEL: 'program_name'
        name: name
        selected: (world) -> name == sprite.get 'editing'
        click: -> sprite.put 'editing', name
      }
      _.extend buttons, extensions
    ]
    _.extend program, program_behavior()

  actions = sprite.get 'actions'
  my.assert sprite.is_world(actions), "#{sprite} has no actions world"

  children = []
  actions.keys([]).map (key) ->
    # if contents is a string, it is a primitive function.
    # if contents is an RxArray, it is a list of commands.
    contents = actions.get(key)
    children.push program_row(key, contents.all()) unless _.isString(contents)
  children
