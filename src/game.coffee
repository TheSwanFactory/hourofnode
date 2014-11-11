{vector} = require './god/vector'

games = {
  baseline: require("./game/baseline").game
  example: require("./game/example").game
}

IPAD = [1024, 690]
HALF_WIDTH = IPAD[0] / 2
SCALE = 30

baseline = {
  name: "The Hour of Node"

  # Geometry
  screen_dimensions: IPAD
  grid_size: HALF_WIDTH
  cell_count: 8
  cell_size: (world) -> world.get('grid_size') / world.get('cell_count')

  goal: {
    clicks: 0
    ticks: 0
    bricks: 0
  }

  language: {
    # Array of Operation, key, argument
    idle:    ['.call', 'go', 0]
    forward: ['.call', 'go', vector.to.front]
    reverse: ['.call', 'go', vector.to.back]
    left:    ['.call', 'turn', vector.to.left ]
    right:   ['.call', 'turn', vector.to.right]
  }

  shapes: {
    turtle: [
      "M37,#{SCALE} l7,-21 a1,2 0 1,0 -7,21z m-7,0m7,0 l7,21 a1,2 0 1,1 -7,-21z m-7,0m-7,0 l7,-21 a1,2 0 1,0 -7,21z m7,0m-7,0 l7,21 a1,2 0 1,1 -7,-21z m7,0m17.5,0 a3,2 0 0,0 14,0 a3,2 0 0,0 -14,0 z m-24.5,0"
      "M10,#{SCALE} a3,2 0 1,0 42,0 a3,2 0 1,0 -42,0z"
    ]
  }

  levels: [
    {
      name: 'Move the Turtle to the Exit'
      sprites: [
        {
          name: 'me'
          shape: 'turtle'
          position: [0,0]
          color: 'limegreen'
          programs: {first: [], repeat: ['forward']}
          editable: true
        }
      ]
    }
  ]
}

choose_game = (query) -> games[query.name]

extensible = ['language', 'shapes']

merge = (stock, custom) ->
  addons = {}
  extensible.map (key) ->
    addons[key] = $.extend stock[key], custom[key]
  $.extend stock, custom, addons

exports.game = (query) ->
  new_game = choose_game query
  merge baseline, new_game
