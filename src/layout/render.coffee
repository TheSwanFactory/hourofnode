#
# render.coffee
# Role: display the world and its children on a web page
# Responsibility: 
# * extract displayable attributes of worlds
# * render in an updateable way as HTML using Reactive Coffee's `bind` method
# * call out to 'draw' to render SVG graphics
#
# TODO: merge/refactor with draw code

{my} = require '../my'

get_style = (world) ->
  style = {
    border: world.get 'border'
    background: world.get 'fill'
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
      #return draw(child) if child.get('path')?
      render_world(child)
    if world.get_local('name')?
      results.push T.p {
        class: ['name', world.get('selected')]
      }, world.bind() -> world.get('name')
    results
    
  render_world = (world) ->
    labels = world.labels([world, 'render', 'world'])
    attrs = {
      id: "#{labels.length}_#{labels.join '_'}"
      class: labels 
      style: world.bind() -> get_style(world)
    }
    add_behavior(attrs, world)
    T.div attrs, world.bind() -> render_children(world) 
  
  T.div {id: 'root'}, render_world(root)
