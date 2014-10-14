{draw_turtle} = require('./draw_turtle')
{draw_grid} = require('./draw_grid')

exports.config = {
  size: 480
  split: 6
  scale: (world, args) ->
    world.get('size') / world.get('split')
  grid: draw_grid
  turtles: draw_turtle
  current: "current"
  controls: "controls"
}
