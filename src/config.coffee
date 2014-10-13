{draw_turtle} = require('./draw_turtle')
{draw_grid} = require('./draw_grid')

exports.config = {
  size: 480
  split: 6
  scale: (world, args) ->
    world.get('size') / world.get('split')
  grid: draw_grid
  turtles: {
    stroke: "green"
    path: (world, args) ->
      size = world.get('size')
      scale = world.get('scale')
      path = "M600,500 l100,-300 a10,20 0 1,0 -100,300z
               M600,500 l100,300  a10,20 0 0,1 -100,-300z
               M400,500 l100,-300 a10,20 0 1,0 -100,300z
               M400,500 l100,300  a10,20 0 0,1 -100,-300z
               M100,500 a20,15 0 0,0 200,0 a20,15 0 0,0 -200,0z
               M850,500 a20,5 0 0,0 -200,0 a20,5 0 0,0 200,0z
              M180,530 a3,2 0 1,0 -40,0 a3,2 0 1,0 40,0z
              M180,470 a3,2 0 1,0 -40,0 a3,2 0 1,0 40,0z
      " 
    children: {
      ME: {
        i: 3
        j: 3
        fill: "#88ff88"
      }
    }
  }
}
