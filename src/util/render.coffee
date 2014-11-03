my = require '../my'

render_world = (world) ->
  world.map_children (child) ->
      "#{child} "
      
exports.render = (world) ->
  T = world.T()
  T.div {id: world}, world.bind() -> render_world(world)
  