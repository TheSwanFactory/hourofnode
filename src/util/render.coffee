my = require '../my'
exports.render = (root) ->
  T = root.T()
  get_style = (world) ->
    {
      border: "1px solid #{world.get('stroke')}"
      background: world.get 'fill'
      height: world.get 'height'
      width: world.get 'width'
    }
  render_children = (world) ->
    world.map_children (child) ->
        "#{child} "

  render_world = (world) ->
    dict = {
      id: world
      class: world.labels(['render', 'world'])
      style: get_style(world)
    }
    T.div dict, world.bind() -> render_children(world)  
  
  render_world(root)
