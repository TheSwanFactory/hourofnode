{my} = require '../my'
{make} = require '../render/make'
{events} = require './mixins/events'

exports.controls = () ->
  buttons = make.buttons(
    'control',
    ['reload', 'rewind', 'run', 'step', 'edit'],
    my.control,
    (world, args) ->
      world.send world.get('name'), world
  )
  _.extend buttons, events
