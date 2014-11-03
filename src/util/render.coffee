my = require '../my'

exports.render = (world) ->
  T = world.T()
  T.div {id: world}
  