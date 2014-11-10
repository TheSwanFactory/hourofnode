{vector} = require('../god/vector')

IPAD = [1024, 690]
HALF_WIDTH = IPAD[0] / 2
SCALE = 30

export.game = {
  name: "The Hour of Node"
  canvas: IPAD
  grid_size: HALF_WIDTH
  cell_count: 8
  cell_size: (world) -> world.get('grid_size') / world.get('cell_count')

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
  
  paths: {
    turtle: [
      "M37,#{SCALE} l7,-21 a1,2 0 1,0 -7,21z m-7,0m7,0 l7,21 a1,2 0 1,1 -7,-21z m-7,0m-7,0 l7,-21 a1,2 0 1,0 -7,21z m7,0m-7,0 l7,21 a1,2 0 1,1 -7,-21z m7,0m17.5,0 a3,2 0 0,0 14,0 a3,2 0 0,0 -14,0 z m-24.5,0"
      "M10,#{SCALE} a3,2 0 1,0 42,0 a3,2 0 1,0 -42,0z"
    ]
    diamond: [
      "M0,#{SCALE} l#{SCALE},#{SCALE} l#{SCALE},-#{SCALE} l-#{SCALE},-#{SCALE} Z"
    ]
  }
  
  levels: [
    {
      name: 'Move the Turtle to the Exit'
      sprites: [
        {
          name: 'me'
          kind: 'turtle'
          position: [0,0]
          color: 'limegreen'
          programs: {once: [], repeat: ['forward']}
          programmable: true
        }
        {
          name: 'exit'
          kind: 'diamond'
          position: [0,4]
          color: 'red'
          programs: {once: [], repeat: []}
        }
      ]
    }
  ]
}
