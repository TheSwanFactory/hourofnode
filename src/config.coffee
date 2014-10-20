{grid} = require('./config/grid')
{turtles} = require('./config/turtles')
{controls} = require('./config/controls')

exports.config = {
  size: 480
  split: 6
  scale: (world, args) ->
    world.get('size') / world.get('split')
  current: undefined
  _CHILDREN: [
    grid
    turtles
    controls
  ]
}
