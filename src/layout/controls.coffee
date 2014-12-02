{my} = require '../my'
{make} = require '../render/make'
{events} = require './mixins/events'

exports.controls = () ->
  buttons = make.buttons(
    'control',
    ["step", "run", "reset", "edit"],
    my.control,
    (world, args) ->
      console.log 'control send', world.get('name')
      world.send world.get('name'), world
  )
  my.extend buttons, events
