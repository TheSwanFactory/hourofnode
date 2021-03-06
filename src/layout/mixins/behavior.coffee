#
# behavior.coffee
#
# A Behavior is a dictionary of Words and Actions
# Actions can be either a list of actions (array)
# or a sentence (string)
#
# Role: create and display program objects
#
# Responsibility: 
# * populate behavior pane of sprite inspector
# * display the current behavior and command
# * apply command events to the selected program
# * send next commmand on step events

{my} = require '../../my'
{make} = require '../../render/make'
{programs} = require './programs'

# TODO: Editing Issues
# * add new programs
# * rename events
# * select the target program
# * reorder commmands within and between programs
# * drag commands from above into a program
# * drag programs into the commands view!

exports.behavior = (sprite) ->
  rows = make.rows 'behavior', programs(sprite)
  _.extend rows, {
    y: (world) -> world.index * my.row.spacing
    class: 'program'
  }
