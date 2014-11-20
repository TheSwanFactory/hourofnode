# NO LONGER USED - BEING REFACTORED

#
# sprite_state.coffee
#
# Role: return a dictionary UI to view & edit sprite state
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
    (button, args) -> button.editable = true
  )
  
  show_paths = (button) -> 'shape' == button.get('_LABEL')
  text_for = (button) -> sprite_dict[ button.get '_LABEL' ] 

  status_buttons._AUTHORITY = my.dup status_buttons._AUTHORITY, {
    name: (button) -> text_for(button) unless show_paths(button)
    paths: (button) -> sprite_dict.paths if is_paths(world)
  }

  behavior_dict = sprite.get 'behavior'
  

  language_row = make.buttons(
    'language',
    Object.keys behavior_dict 
    my.button,
    (world, args) -> world.send 'do', world.get('value')
  )

  behavior = make.rows 'behavior', sprites.behavior.map(program_row)

  make.rows 'sprite_state', [
    status_buttons
    language_row
    strategy_table
  ]
