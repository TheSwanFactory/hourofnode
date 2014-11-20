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

exports.programs = (sprite) ->
  behavior = sprite.get('behavior')
  my.assert _.isObject behavior, 'has behavior dict'
  console.log 'programs', behavior
  
  children = []
  for name, program of behavior
    console.log 'programs name program', name, program
    children.push program_row(name, program)
  children
  