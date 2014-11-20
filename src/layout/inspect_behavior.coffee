#
# inspect_behavior.coffee
#
# Role: create and display program objects
#
# Responsibility: 
# * populate behavior pane of sprite inspector
# * display the current behavior and command
# * apply command events to the selected program
# * send next commmand on step events
#

{my} = require '../my'
{make} = require '../render/make'

program_row = (name, program) ->
  make.columns "program-#{name}", [
    name # action: select this behavior/ edit name
    make.buttons(
      name,
      program
      my.command,
      (world, args) -> console.log 'TODO: rearrange'
    )
  ]

programs = (sprite) ->
  children = []
  for name, program in sprite.get('behavior')
    children.push program_row(name, program)
  children
  
exports.inspect_behavior = (sprite) ->
  make.rows 'behavior', programs(sprite)
