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
# A Behavior is a dictionary of Programs
# A Program is a sequence of Commands
# A Command is a word in the Language

{my} = require '../my'
{make} = require '../render/make'

# TODO: Display Issues
# * get the second row to display
# * make the haders fully visible
# * make the backgrounds full-width
# * highlight the current command
# * indicate the target program somehow
# 
# TODO: Editing Issues
# * add new programs
# * rename events
# * select the target program
# * reorder commmands within and between programs
# * drag commands from above into a program
# * drag programs into the commands view!
# 
# TODO: Behavior Issues
# * step through a program
# * send next command to sprite
# * detect and handle interruptions
#   * hitting boundaries
#   * collisions
#   * finishing levels
# 

program_row = (name, program) ->
  make.columns "program", [
    {
      _LABEL: 'program_name'
      name: name
    }
    make.buttons(
      "instructions",
      program
      my.command,
      (world, args) -> console.log 'TODO: rearrange'
    )
  ]

program_label = (row) -> 

  
programs = (sprite) ->
  behavior = sprite.get('behavior')
  my.assert _.isObject behavior, 'has behavior dict'
  console.log 'inspect_behavior', behavior
  
  children = []
  for name, program of behavior
    console.log 'inspect_behavior name program', name, program
    children.push program_row(name, program)
  children
  
processor = {
  current_program: label
  target_program: label
  next_command: 0
}

exports.inspect_behavior = (sprite) ->
  rows = make.rows 'behavior', programs(sprite)
  default_program = rows._CHILDREN[0]
  my.assert default_program, "no default_program"

  label = default_program._LABEL
  my.extend rows, processor, {
    y: (world) -> world.index * my.row.spacing
  }
