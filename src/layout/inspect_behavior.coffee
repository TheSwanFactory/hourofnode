#
# inspect_behavior.coffee
#
# A Behavior is a dictionary of Programs
# A Program is a sequence of Commands
# A Command is a word in the Language
#
# Role: create and display program objects
#
# Responsibility: 
# * populate behavior pane of sprite inspector
# * display the current behavior and command
# * apply command events to the selected program
# * send next commmand on step events

{my} = require '../my'
{make} = require '../render/make'
{processor} = require './processor'
{programs} = require './programs'

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

editor = (initial_label) -> {
  open_program: initial_label
}

exports.inspect_behavior = (sprite) ->
  rows = make.rows 'behavior', programs(sprite)
  default_program = rows._CHILDREN[0]
  my.assert default_program, "no default_program"

  initial_label = default_program._LABEL
  my.extend rows,
    processor(initial_label),
    editor(initial_label),
    {
      _EXPORTS: ['step']
      y: (world) -> world.index * my.row.spacing
    }
