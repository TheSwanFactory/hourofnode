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
    x = scale*(world.get('i'))
    y = scale*(world.get('j'))
    angle = world.get('angle')
    "translate(#{x},#{y}) rotate(#{angle})"
  current: -> "No world"
  signals: {
    left:  {name: "LL", do: "turn", dir: 1}
    right: {name: "RR", do: "turn", dir: -1}
    front: {name: "GO", do: "go", dir: 1}
    back: {name: "REV", do: "go", dir: -1}
    step: {name: "1>", do: "step", n: 1}
  }
  _CHILDREN: [
    grid
    turtles
    controls
  ]
}
