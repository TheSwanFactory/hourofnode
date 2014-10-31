assert = require 'assert'

normalize = (paths) ->
  return [] unless paths
  paths = paths.all() unless _.isArray(paths) 
  paths
  
exports.draw = (world) ->
  SVG = world.SVG()

  draw_self = (world) ->
    #console.log "draw_self #{world}"
    dict = {
      class: world.labels(['draw', 'self'])
      stroke: world.get 'stroke'
      fill: world.get 'fill'
    }
    dict['stroke'] = 'goldenrod' if world.get('selected')
    paths = world.get 'path'
    return undefined unless paths?
    paths = if world.is_array(paths) then paths.all() else [paths]
    elements = paths.map (path) ->
      dict['d'] = path
      SVG.path dict
    return elements unless world.get('name')?
    elements.push SVG.text world.get('name_style'), world.bind() -> world.get('name')
    elements
    
  draw_children = (world) -> world.map_children(draw_world)  

  draw_world = (world) ->
    #console.log "draw_world #{world} kids:#{world.has_children()}", world, world.index
    dict = {
      class: world.labels(['draw', 'world'])
      transform: world.bind() -> world.get('transform')
    }
    clicker = world.get_raw 'click'
    dict['click'] = -> clicker(world) if clicker? and !world.has_children()
    SVG.g dict, world.bind() ->
      paths = normalize draw_self(world)
      child_paths = normalize draw_children(world)
      for child in child_paths
        paths.push child
      paths
  device = world.get('device') or {width: 500, height: 500}
  SVG.svg {
    xmlns: "http://www.w3.org/2000/svg"
    "xmlns:xlink": "http://www.w3.org/1999/xlink"
    class: "svg_grid #{world}"
    width: device.width
    height: device.height
  }, [
    draw_world(world) 
  ]
