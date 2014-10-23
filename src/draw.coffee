assert = require 'assert'

exports.draw = (world) ->
  SVG = world.SVG()
  grid_size = world.get('size')

  draw_self = (world) ->
    assert !world.has_children()
    #console.log "draw_path #{world}"
    dict = {
      class: ['draw_path', "#{world}"]
      stroke: world.get 'stroke'
      fill: world.get 'fill'
    }
    dict['stroke'] = 'red' if world.get('selected')
    paths = world.get 'path'
    return unless paths?
    paths = [paths] if paths !instanceof Array
    elements = paths.map (path) ->
      dict['d'] = path
      SVG.path dict

    return elements unless world.get('name')?
    elements.push SVG.text {
      x: 0, y:5
    }, world.bind() -> world.get('name')
    elements
    
  draw_children = (world) ->
    world.map_children(draw_world) if world.has_children() 

  draw_world = (world) ->
    #console.log "draw_world #{world}"
    paths = draw_children(world) or draw_self(world)
    dict = {
      klass: ['draw_world', "#{world}"] # TODO: use 'class' properly
      transform: world.bind() -> world.get('transform')
    }
    clicker = world.get_raw 'click'
    # TODO: find a more elegant way to inherit generic click behavior
    dict['click'] = -> clicker(world) if clicker? and !world.has_children()
    SVG.g dict, paths

  #console.log world
  SVG.svg {
    xmlns: "http://www.w3.org/2000/svg"
    "xmlns:xlink": "http://www.w3.org/1999/xlink"
    class: "svg_grid #{world}"
    width: grid_size*1.5  
    height: grid_size  
  }, [
    draw_world(world) 
  ]
