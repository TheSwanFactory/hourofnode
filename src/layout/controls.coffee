{my} = require '../my'
{make} = require '../render/make'
{events} = require './mixins/events'

exports.controls = () ->
  buttons = make.buttons(
    'control',
    [
      'reload'
      'rewind'
      {
        name:   (world) -> if world.get('running') then 'stop' else 'run'
        _LABEL: 'run'
      }
      'step'
      'edit'
    ],
    my.control,
    (world, args) ->
      world.send world.get('name'), world
  )
  _.extend buttons, events
