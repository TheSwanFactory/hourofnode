{my} = require './my'
{timer} = require './config/timer'
{layout} = require './config/layout'
{programs} = require './config/programs'
{formatter} = require './config/formatter'
{inspector} = require './config/inspector'
{game} = require './games/game-testing'

baseline = {
  device: my.device
  grid: my.grid
  size: my.grid.size
  split: my.grid.split
  margin: my.margin
  scale: (world) -> world.get('size') / world.get('split')
  
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
    victory:    {name: "+", do: "done", dir: 1}
    failure:    {name: "-", do: "done", dir: -1}
  }
  _CHILDREN: [
    timer
    layout
    programs
    #formatter
  ]
}

setup = ->
  baseline.game = game
  baseline.level = 0
  baseline

exports.config = setup()
