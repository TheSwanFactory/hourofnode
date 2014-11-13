{my} = require '../my'
{make} = require '../render/make'

exports.controls = make.buttons(
  'control',
  ["step", "run", "stop", "reset"],
  my.control,
  (world, args) -> world.send world.get('value')
)

