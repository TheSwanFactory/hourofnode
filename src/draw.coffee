{draw_grid} = require('./draw_grid')
{draw_turtle} = require('./draw_turtle')

exports.draw = (SVG, world) ->
  grid_size = world.get('size')
  grid_split = world.get('split')

  draw_path = (label, doc) ->
    SVG.path {
      class: "draw #{label}"
      d: doc['path']
      stroke: doc['stroke']
      fill: doc['fill']
    }
  
  SVG.svg {
    xmlns: "http://www.w3.org/2000/svg"
    "xmlns:xlink": "http://www.w3.org/1999/xlink"
    class: 'svg_grid'
    width: grid_size  
    height: grid_size  
  }, _.flatten [
    for key, value in world.get('paths')
      draw_path(key, value)
    draw_grid(SVG, world)
    draw_turtle(SVG, world)
  ]
