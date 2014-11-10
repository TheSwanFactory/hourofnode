{vector} = require('../god/vector')

IPAD = [1024, 690]
HALF_WIDTH = IPAD[0] / 2

export.game = {
  canvas: IPAD
  grid_size: HALF_WIDTH
  cell_count: 8
  cell_size: (world) -> world.get('grid_size') / world.get('cell_count')
  
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

# The game used in the test suite
SCALE = 30
turtle = (color, x, y, prog) -> {
  path: [
    "M37,#{SCALE} l7,-21 a1,2 0 1,0 -7,21z m-7,0m7,0 l7,21 a1,2 0 1,1 -7,-21z m-7,0m-7,0 l7,-21 a1,2 0 1,0 -7,21z m7,0m-7,0 l7,21 a1,2 0 1,1 -7,-21z m7,0m17.5,0 a3,2 0 0,0 14,0 a3,2 0 0,0 -14,0 z m-24.5,0"
    "M10,#{SCALE} a3,2 0 1,0 42,0 a3,2 0 1,0 -42,0z"
  ]
  kind: 'turtle'
  name: 'me'
  p: [x,y], v:[1, 0]
  fill: color
  programs: {default: prog, buffer: []}
}

me = turtle("limegreen", 1, 1, ['forward'])
yu = turtle("darkred", 3, 3, [])
sentry = turtle("red", 4, 4, ['forward', 'forward', 'reverse', 'reverse'])

diamond = (n) -> "M0,#{n} l#{n},#{n} l#{n},-#{n} l-#{n},-#{n} Z"
exit = (col) -> {
  path: [diamond(30)]
  name: 'exit'
  p: [6,col]
  fill: "maroon"
  programs: {turtle: ['victory']}
}

exports.game = {
  name: 'Test Game'
  levels: [
    {name: 'End of the Line', sprites: [me, exit(1)]}
    {name: 'Diagonal Thinking', sprites: [me, exit(6)]}
    {name: 'Avoid Obstacle', sprites: [me, yu, exit(6)]}
    {name: 'Avoid Sentry', sprites: [me, sentry, exit(6)]}
  ]
}

