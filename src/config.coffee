{grid} = require('./config/grid')
{turtles} = require('./config/turtles')
{controls} = require('./config/controls')

exports.config = {
  size: 480
  split: 6
  scale: (world, args) ->
    world.get('size') / world.get('split')
  i: 0
  j: 0
  angle: 0    
  transform: (world, args) ->
    scale = world.get('scale')
    x = scale*(world.get('i')+0.5)
    y = scale*(world.get('j')+0.5)
    angle = world.get('angle')
    "translate(#{x},#{y}) rotate(#{angle})"
  current: undefined
  _CHILDREN: [
    grid
    turtles
    controls
  ]
}
