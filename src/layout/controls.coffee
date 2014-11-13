{my} = require '../my'
{make} = require '../render/make'

control_names = ["step", "run", "stop", "reset"]
exports.controls = make.buttons(
  'control',
  control_names,
  my.control,
  (world, args) -> world.send world.get('value')
)

