{my} = require '../my'
{draw} = require './draw'
# TODO: De-Duplicate/Merge Draw

get_style = (world) ->
  style = {
    border: world.get 'border'
    background: world.get('fill')
    height: world.get 'height'
    width: world.get 'width'
    position: 'absolute'
    left: world.get 'x'
    top: world.get 'y'
  }

add_behavior = (attrs, world) ->
  clicker = world.get_raw 'click'
  attrs['click'] = -> clicker(world) if clicker? and !world.has_children()
  
exports.render = (root) ->
  T = root.T()
  
  render_children = (world) ->
    results = world.map_children (child) ->
      return draw(child) if child.get('path')?
      render_world(child)
    if world.get_local('name')?
      results.push T.p {
        class: ['name', world.get('selected')]
      }, world.bind() -> world.get('name')
    results
    
  render_world = (world) ->
    attrs = {
      id: world
      class: world.labels(['render', 'world'])
      style: world.bind() -> get_style(world)
    }
    add_behavior(attrs, world)
    children = render_children(world)
    T.div attrs, children 
  
  T.div {id: 'root'}, render_world(root)
