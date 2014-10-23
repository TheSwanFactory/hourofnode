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
    left:  {name: "<-", do: "turn", dir: 1}
    right: {name: "->", do: "turn", dir: -1}
    front: {name: "^", do: "go", dir: 1}
    back: {name: "v", do: "go", dir: -1}
    step: {name: ">", do: "step", n: 1}
    run: {name: ">>", do: "run", speed: 1}
    stop: {name: "||", do: "run", speed: 0}
    reset: {name: "|<", do: "reset"}
  }
  _CHILDREN: [
    grid
    turtles
    controls
  ]
}
