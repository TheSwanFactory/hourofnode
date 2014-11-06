{my} = require('./my')
{timer} = require('./config/timer')
{layout} = require('./config/layout')
{turtles} = require('./config/turtles')
{sprites} = require('./config/sprites')
{inspector} = require('./config/inspector')

baseline = {
  device: my.device
  grid: my.grid
  size: my.grid.size
  split: my.grid.split
  margin: my.margin
  scale: (world, args) -> world.get('size') / world.get('split')
  i: 0
  j: 0
  x: (world, args) -> world.get('scale') * world.get('i')
  y: (world, args) -> world.get('scale') * world.get('j')
  angle: 0
  translate: (world, args) -> "translate(#{world.get('x')},#{world.get('y')})"
  rotate: (world, args) -> "rotate(#{world.get('angle')})"
  transform: (world, args) -> "#{world.get('translate')} #{world.get('rotate')}"
  name_style: {x: -5, y: 5, fill: "white", stroke: "white"}
  signals: {
    forward: {name: "^", do: "go", dir: 1}
    reverse: {name: "v", do: "go", dir: -1}
    left:    {name: "<-", do: "turn", dir: 1}
    right:   {name: "->", do: "turn", dir: -1}
    idle:    {name: "v", do: "go", dir: 0}
  }
  _CHILDREN: [
    timer
    layout
    turtles
    sprites
  ]
}

setup = ->
  baseline

exports.config = setup()
