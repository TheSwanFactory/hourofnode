{grid} = require('./config/grid')
# {draw_turtle} = require('./draw_turtle')
# {draw_controls} = require('./draw_controls')

exports.config = {
  size: 480
  split: 6
  scale: (world, args) ->
    world.get('size') / world.get('split')
#  grid: draw_grid
#  turtles: draw_turtle
#  controls: draw_controls
  current: "current"
}
