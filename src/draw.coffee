{draw_turtle} = require('./draw_turtle')

exports.draw = (SVG, world) ->
  grid_size = world.get('size')
  grid_split = world.get('split')

  draw_path = (label, world) ->
    dict = {
      class: "draw_path #{label}"
      stroke: world.get 'stroke'
      fill: world.get 'fill'
    }
    paths = world.get 'path'
    paths = [paths] if paths !instanceof Array
    for path in paths
      dict['d'] = path
      SVG.path dict
  SVG.svg {
    xmlns: "http://www.w3.org/2000/svg"
    "xmlns:xlink": "http://www.w3.org/1999/xlink"
    class: 'svg_grid'
    width: grid_size  
    height: grid_size  
  }, _.flatten [
    world.get('grid').map draw_path
    draw_turtle(SVG, world)
  ]
