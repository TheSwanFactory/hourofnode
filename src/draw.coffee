{draw_grid} = require('./draw_grid')
{draw_turtle} = require('./draw_turtle')

exports.draw = (SVG, world) ->
  grid_size = world.get('size')
  grid_split = world.get('split')
  world.put('scale', grid_size / grid_split)
  
  SVG.svg {
    xmlns: "http://www.w3.org/2000/svg"
    "xmlns:xlink": "http://www.w3.org/1999/xlink"
    class: 'svg_grid'
    width: grid_size  
    height: grid_size  
  }, _.flatten [
    draw_grid(SVG, world)
    draw_turtle(SVG, world)
  ]
