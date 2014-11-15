# sprite_state.coffee
#
# Role: display and edit the state of the current sprite
# Responsibility:
# * display and edit status fields
# * display language used for this sprite
# * record and display behavior made using those languages
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
  my.language,
  (world, args) -> world.send 'edit', world.get('value')
)

exports.sprite_state = (sprite) ->

  status_row = make.buttons('status', [
      "shape"
      "name"
      "color"
      "position"
      "direction"
    ], my.button,
    (world, args) -> world.send 'edit', world.get('value')
  )

  language_row = make.buttons(
    'language',
    sprite.get 'words'
    my.button,
    (world, args) -> world.send 'do', world.get('value')
  )

  behavior = make.rows 'behavior', sprites.behavior.map(program_row)

  make.rows 'sprite_state', [
    status_row
    language_row
    strategy_table
  ]
