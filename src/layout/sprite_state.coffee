# sprite_state.coffee
#
# Role: display and edit the state of the current sprite
# Responsibility:
# * display and edit status fields
# * display language used for this sprite
# * record and display behavior made using those languages
# * update program display based on current action
#

{my} = require '../my'
{make} = require '../render/make'

program_row = (program) ->
 make.buttons(
  program.name,
  make.columns 'program', [
    program.name # action: edit the name
    program._children() # action: delete the action?
  ]
  my.language,
  (world, args) -> world.send 'edit', world.get('value')
)

exports.sprite_state = (sprite) ->
  status_buttons = make.buttons('status', [
      "shape"
      "name"
      "color"
      "position"
      "direction"
    ], my.button,
    (world, args) -> world.send 'edit', world.get('value')
  )
  is_paths = (world) -> 'paths' == world.get('_LABEL')
  my.extend status_buttons._AUTHORITY, {
    name: (world) -> sprite[world.get '_LABEL'] unless is_paths(world)
    paths: (world) -> sprite.paths if is_paths(world)
  }

  language_row = make.buttons(
    'language',
    sprite.get 'words'
    my.button,
    (world, args) -> world.send 'do', world.get('value')
  )

  behavior = make.rows 'behavior', sprites.behavior.map(program_row)

  make.rows 'sprite_state', [
    status_buttons
    language_row
    strategy_table
  ]
