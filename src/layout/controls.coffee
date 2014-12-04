{my} = require '../my'
{make} = require '../render/make'
{events} = require './mixins/events'

exports.controls = () ->
  buttons = make.buttons(
    'control',
    ["step", "run", "reset", "edit"],
    my.control,
    (world, args) ->
      world.send world.get('name'), world
  )
  _.extend buttons, events
