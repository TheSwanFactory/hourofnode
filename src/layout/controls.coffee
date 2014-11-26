{my} = require '../my'
{make} = require '../render/make'
{events} = require './mixins/events'

exports.controls = () ->
  buttons = make.buttons(
    'control',
    ["step", "run", "stop", "reset"],
    my.control,
    (world, args) -> world.send world.get('value')
  )
  my.extend buttons, events
