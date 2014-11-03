my = require '../my'
exports.render = (root) ->
  T = root.T()
  render_children = (world) ->
    world.map_children (child) ->
        "#{child} "

  render_world = (world) ->
    T.div {id: world}, world.bind() -> render_children(world)  
  
  render_world(root)
