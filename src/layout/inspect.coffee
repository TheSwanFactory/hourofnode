# inspect.coffee
# Role: display and edit the state of the current sprite
# Responsibility:
# * display and edit status fields
# * display valid commands for this sprite
# * record and display programs made using those commands
# * update program display based on current action
#
# TODO: should this be recreated OR selected for new turtles

{my} = require '../my'
{make} = require '../render/make'

program_row = (program) ->
 make.buttons(
  program.name,
  make.columns 'program', [
    program.name # edit the name
    program._children() # delete the action
  ]
  my.command,
  (world, args) -> world.send 'edit', world.get('value')
)

exports.inspect = (sprite) ->

  status_row = make.buttons('status', [
      "shape"
      "name"
      "color"
      "position"
      "direction"
    ], my.button,
    (world, args) -> world.send 'edit', world.get('value')
  )

  command_row = make.buttons(
    'commands',
    sprite.get 'commands'
    my.button,
    (world, args) -> world.send 'do', world.get('value')
  )

  strategy_table = 
    make.rows 'inspect', sprites.programs.map(program_row)

  make.rows 'inspect', [
    status_row
    command_row
    strategy_table
  ]
