{game} = require('./config/game')
{layout} = require('./config/layout')
{turtles} = require('./config/turtles')
{sprites} = require('./config/sprites')
{inspector} = require('./config/inspector')

exports.config = {
  device_width: 1024
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
  name_style: (world, args) -> {x: -5, y: 5}
  current: -> "No world"
  _CHILDREN: [
    game
    layout
    turtles
    sprites
    inspector
  ]
}
