{my} = require './my'
{timer} = require './config/timer'
{layout} = require './config/layout'
{turtles} = require './config/turtles'
{sprites} = require './config/sprites'
{inspector} = require './config/inspector'
{game} = require './games/game-testing'

baseline = {
  device: my.device
  grid: my.grid
  size: my.grid.size
  split: my.grid.split
  margin: my.margin
  scale: (world) -> world.get('size') / world.get('split')
  
  # TODO: Who is calling these values?!?
  x: (world) -> world.get('scale') * world.get('i')
  y: (world) -> world.get('scale') * world.get('j')
  angle: 0
  translate: (world) -> "translate(#{world.get('x')},#{world.get('y')})"
  rotate: (world) -> "rotate(#{world.get('angle')})"
  transform: (world) -> "#{world.get('translate')} #{world.get('rotate')}"
  name_style: {x: -5, y: 5, fill: "white", stroke: "white"}
  current_level: (world) ->
    game = world.get 'game'
    level = world.get 'level'
    game.levels[level]

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
  baseline.game = game
  baseline.level = 0
  baseline

exports.config = setup()
