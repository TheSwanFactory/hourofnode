{my} = require '../my'
{draw} = require './draw'

exports.render = (root) ->
  T = root.T()
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
  render_children = (world) ->
    results = world.map_children (child) ->
      return draw(child) if child.get('path')?
      render_world(child)
    name = world.get('name')
    results.push T.span(name) if name?
    results
  render_world = (world) ->
    dict = {
      id: world
      class: world.labels(['render', 'world'])
      style: get_style(world)
    }
    # TODO: De-Duplicate from Draw
    clicker = world.get_raw 'click'
    dict['click'] = -> clicker(world) if clicker? and !world.has_children()
    T.div dict, render_children(world) #world.bind() -> 
  
  render_world(root)
