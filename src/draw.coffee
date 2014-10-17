exports.draw = (world) ->
  SVG = world.SVG()
  grid_size = world.get('size')

  draw_path = (world) ->
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
      
  draw_child = (world) ->
    SVG.g {
      class: ['draw_child', "#{world}"]
      transform: world.bind -> world.get('transform')
    }, world.bind -> _.flatten [
      draw_path(world)
    ]
    
  SVG.svg {
    xmlns: "http://www.w3.org/2000/svg"
    "xmlns:xlink": "http://www.w3.org/1999/xlink"
    class: 'svg_grid'
    width: grid_size  
    height: grid_size  
  }, _.flatten [
    world.map_child (section) ->
      section.map_child draw_child
  ]
