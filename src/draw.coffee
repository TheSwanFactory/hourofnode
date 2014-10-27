assert = require 'assert'

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
    paths = [paths] if !world.is_array(paths)
    elements = paths.map (path) ->
      dict['d'] = path
      SVG.path dict
    return elements unless world.get('name')?
    elements.push SVG.text world.get('name_style'), world.bind() -> world.get('name')
    elements
    
  draw_children = (world) -> world.map_children(draw_world)  

  draw_world = (world) ->
    #console.log "draw_world #{world} kids:#{world.has_children()}", world
    dict = {
      class: world.labels(['draw', 'world'])
      transform: world.bind() -> world.get('transform')
    }
    clicker = world.get_raw 'click'
    dict['click'] = -> clicker(world) if clicker? and !world.has_children()
    SVG.g dict, world.bind() ->
      paths = draw_self(world)
      paths = [] unless paths?
      paths = paths .all() unless _.isArray(paths)
      child_paths = draw_children(world)
      child_paths = child_paths.all() unless _.isArray(child_paths)
      for child in child_paths
        paths.push child
      paths

  device_width = world.get('device_width') or 1024
  console.log "draw", device_width, world
  SVG.svg {
    xmlns: "http://www.w3.org/2000/svg"
    "xmlns:xlink": "http://www.w3.org/1999/xlink"
    class: "svg_grid #{world}"
    width: device_width  
    height: device_width * 3 / 4  
  }, [
    draw_world(world) 
  ]
