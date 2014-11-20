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
    {
      _LABEL: 'name'
      name: name
      background: 'white'
      height: my.button.size
      width: my.button.size
    }
    make.buttons(
      name,
      program
      my.command,
      (world, args) -> console.log 'TODO: rearrange'
    )
  ]

programs = (sprite) ->
  behavior = sprite.get('behavior')
  my.assert _.isObject behavior, 'has behavior dict'
  console.log 'inspect_behavior', behavior
  children = []
  for name, program of behavior
    console.log 'inspect_behavior name program', name, program
    children.push program_row(name, program)
  children
  
exports.inspect_behavior = (sprite) ->
  rows = make.rows 'behavior', programs(sprite)
  my.extend rows, {
    height: my.row.size
    y: (world) -> world.index * my.row.spacing
    
  }
