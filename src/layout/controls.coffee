{my} = require '../my'
{make} = require '../render/make'
{events} = require '../god/events'

exports.controls = (level_dict) ->
  buttons = make.buttons(
    'control',
    ["step", "run", "stop", "reset"],
    my.control,
    (world, args) -> world.send world.get('value')
  )
  my.extend buttons, events
