exports.draw = (SVG, world) ->
  grid_size = world.get('size')
  grid_split = world.get('split')

  draw_path = (label, world) ->
    dict = {
      class: ['draw_path', label]
      stroke: world.get 'stroke'
      fill: world.get 'fill'
    }
    paths = world.get 'path'
    paths = [paths] if paths !instanceof Array
    for path in paths
      dict['d'] = path
      SVG.path dict
      
  draw_world = (label, world) ->
    SVG.g {
      class: ['draw_world', label]
      transform: world.bind -> world.get('transform')
    }, world.bind -> _.flatten [
      draw_path(label,world)
    ]
    
  SVG.svg {
    xmlns: "http://www.w3.org/2000/svg"
    "xmlns:xlink": "http://www.w3.org/1999/xlink"
    class: 'svg_grid'
    width: grid_size  
    height: grid_size  
  }, _.flatten [
    world.get('grid').map draw_world
    world.get('turtles').getChildren().map draw_world
  ]
