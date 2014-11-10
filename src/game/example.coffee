{vector} = require('../god/vector')

IPAD = [1024, 690]
HALF_WIDTH = IPAD[0] / 2
SCALE = 30

exports.game = {
  name: "The Hour of Node"

  # Geometry
  screen_dimensions: IPAD
  grid_size: HALF_WIDTH
  cell_count: 8
  cell_size: (world) -> world.get('grid_size') / world.get('cell_count')

  goal: {
    clicks: 1
    ticks: 4
    bricks: 1
  }

  language: {
    # Array of Operation, key, argument
    idle:    ['.call', 'go', 0]
    forward: ['.call', 'go', vector.to.front]
    reverse: ['.call', 'go', vector.to.back]
    left:    ['.call', 'turn', vector.to.left ]
    right:   ['.call', 'turn', vector.to.right]
    victory: ['.send', 'done',  1]
    failure: ['.send', 'done', -1]
  }

  # Shapes
  turtle: [
    "M37,#{SCALE} l7,-21 a1,2 0 1,0 -7,21z m-7,0m7,0 l7,21 a1,2 0 1,1 -7,-21z m-7,0m-7,0 l7,-21 a1,2 0 1,0 -7,21z m7,0m-7,0 l7,21 a1,2 0 1,1 -7,-21z m7,0m17.5,0 a3,2 0 0,0 14,0 a3,2 0 0,0 -14,0 z m-24.5,0"
    "M10,#{SCALE} a3,2 0 1,0 42,0 a3,2 0 1,0 -42,0z"
  ]
  diamond: [
    "M0,#{SCALE} l#{SCALE},#{SCALE} l#{SCALE},-#{SCALE} l-#{SCALE},-#{SCALE} Z"
  ]

  # Levels
  has: [
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
        {
          name: 'exit'
          shape: 'diamond'
          position: [0,4]
          color: 'red'
          programs: {turtle: ['victory']}
        }
      ]
    }
  ]
}
