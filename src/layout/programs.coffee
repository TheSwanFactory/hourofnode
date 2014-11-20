#
# programs.coffee
#
# A Behavior is a dictionary of Programs
# A Program is a sequence of Commands
# A Command is a word in the Language
#
# Role: create and run a single program
#
# Responsibility: 
# * create behavior row
# * track and return next command
# * advance counter (or fault)

{my} = require '../my'
{make} = require '../render/make'

program_behavior = (name) -> {
  next_index: 0
  next_command: (world) ->
    program = world.get 'running_program'
}

program_row = (name, contents) ->
  program = make.columns name, [
    {
      _LABEL: 'program_name'
      name: name
    }
    make.buttons(
      "instructions",
      contents
      my.command,
      (world, args) -> console.log 'TODO: rearrange'
    )
  ]
  my.extend program, program_behavior()
  

exports.programs = (sprite) ->
  behavior = sprite.get('behavior')
  my.assert _.isObject behavior, 'has behavior dict'
  console.log 'programs', behavior
  
  children = []
  for name, contents of behavior
    console.log 'programs name program', name, contents
    children.push program_row(name, contents)
  children
  