{my} = require '../my'
{draw} = require './draw'
# TODO: De-Duplicate/Merge Draw

get_style = (world) ->
  style = {
    border: "1px solid #{world.get('stroke')}"
    background: world.get 'fill'
    height: world.get 'height'
    width: world.get 'width'
    position: 'absolute'
    left: world.get 'x'
    top: world.get 'y'
  }
  style['border'] = "3px solid goldenrod" if world.get('selected')
  style

add_behavior = (attrs, world) ->
  clicker = world.get_raw 'click'
  attrs['click'] = -> clicker(world) if clicker? and !world.has_children()
  
exports.render = (root) ->
  T = root.T()
  
  render_children = (world) ->
    results = world.map_children (child) ->
      return draw(child) if child.get('path')?
      render_world(child)
    name = world.get('name')
    results.push T.span({class: 'name'}, name) if name?
    results
    
  render_world = (world) ->
    attrs = {
      id: world
      class: world.labels(['render', 'world'])
      style: get_style(world)
    }
    add_behavior(attrs, world)
    children = render_children(world)
    mutation_signal = world.get_local('update_on')
    if mutation_signal?
      console.log "render_children: update_on #{world}"
      results_cell = world.rx().cell children
      # TODO: make this work
      # world.handle mutation_signal, ->  results_cell.set render_children(world)
      
    T.div attrs, children 
  
  T.div {id: 'root'}, render_world(root)
